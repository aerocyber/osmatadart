// Copyright 2021 aerocyber
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Check: name in data
Map checkforName(List<Map> data, String name) {
  for (int x = 0; x < data.length; x++) {
    if (data[x]["Name"] == name) {
      return {"Status": "Success", "Detail": data[x]};
    }
  }
  return {"Status": "Fail", "Detail": name + " is not found"};
}

// Check: url in data
Map checkforUrl(List<Map> data, Uri url) {
  for (var x = 0; x < data.length; x++) {
    if (data[x]["Url"] == url) {
      return {"Status": "Success", "Detail": data[x]};
    }
  }
  return {"Status": "Fail", "Detail": url.toString() + " is not found"};
}

// Feature Add Osmation
Map osmate(List<Map> data, String name, Uri url, List category) {
  var chname = checkforName(data, name);
  var churl = checkforUrl(data, url);
  if (chname["Status"] == "Success") {
    return {"Status": "Fail", "Detail": name + " is existing"};
  } else if (churl["Status"] == "Success") {
    return {"Status": "Fail", "Detail": url.toString() + " is existing"};
  } else if (chname["Status"] == "Error") {
    return {"Status": "Error", "Detail": chname["Detail"]};
  } else if (churl["Status"] == "Error") {
    return {"Status": "Error", "Detail": churl["Detail"]};
  } else {
    List cat = [];
    if (category.isEmpty) {
      cat = [];
    } else {
      cat = category;
    }
    var db = {"Name": name, "Url": url, "Category": cat};
    data.add(db);
    return {"Status": "Success", "Detail": data};
  }
}

// Feature Remove Osmation
Map deosmate(String name, List<Map> data) {
  var chname = checkforName(data, name);
  if (chname["Status"] == "Fail") {
    return {"Status": "Fail", "Detail": name + " is not existing"};
  } else if (chname["Status"] == "Error") {
    return {"Status": "Error", "Detail": chname["Detail"]};
  } else {
    var index = data[data.indexOf(chname["Detail"])];
    data.remove(index);
    return {"Status": "Success", "Detail": data};
  }
}

// Feature Retrieve Osmata spec version followed
Map getSpecVersion() {
  return {"Status": "Success", "Detail": "osmata-spec version 1.0"};
}

// Feature Get Url by name
Map getUrl(String name, List<Map> data) {
  var chname = checkforName(data, name);
  if (chname["Status"] == "Fail") {
    return {"Status": "Fail", "Detail": name + " is not existing"};
  } else if (chname["Status"] == "Error") {
    return {"Status": "Error", "Detail": chname["Detail"]};
  } else {
    return {
      "Status": "Success",
      "Detail": data[data.indexOf(chname["Detail"])]
    };
  }
}

// Feature Edit name
Map editName(List<Map> data, String oldName, String newName) {
  var chnameold = checkforName(data, oldName);
  var chnamenew = checkforName(data, newName);
  if (chnameold["Status"] == "Success") {
    return {"Status": "Fail", "Detail": oldName + " is existing"};
  } else if (chnamenew["Status"] == "Success") {
    return {"Status": "Fail", "Detail": newName + " is existing"};
  } else if (chnameold["Status"] == "Error") {
    return {"Status": "Error", "Detail": chnameold["Detail"]};
  } else if (chnamenew["Status"] == "Error") {
    return {"Status": "Error", "Detail": chnamenew["Detail"]};
  } else {
    data[(chnameold["Detail"])]["Name"] = newName;
    return {"Status": "Success", "Detail": data};
  }
}

// Feature Edit Url
Map editUrl(List<Map> data, String name, Uri newUrl) {
  var churlold = checkforName(data, name);
  var churlnew = checkforUrl(data, newUrl);
  if (churlold["Status"] == "Fail") {
    return {"Status": "Fail", "Detail": name + " is not existing"};
  } else if (churlnew["Status"] == "Success") {
    return {"Status": "Fail", "Detail": newUrl.toString() + " is existing"};
  } else if (churlold["Status"] == "Error") {
    return {"Status": "Error", "Detail": churlold["Detail"]};
  } else if (churlnew["Status"] == "Error") {
    return {"Status": "Error", "Detail": churlnew["Detail"]};
  } else {
    data[(churlold["Detail"])]["Name"] = newUrl.toString();
    return {"Status": "Success", "Detail": data};
  }
}
