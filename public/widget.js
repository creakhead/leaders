function getCategories(asset) {
  var validMediaTypes = ['5K', '10K', 'Half Marathon', 'Marathon'];
  var categories = [];

  // use the mediaTypes to get
  // categories we want to show
  $(asset.assetMediaTypes).each(function() {
    var parts  = this.mediaType.mediaTypeName.split("\\");
    var mediaType = parts[parts.length - 1];
    if($.inArray(mediaType, validMediaTypes) != -1) {
      categories.push({mediaType: mediaType, url: 'http://localhost:3000/subcat/' + mediaType.replace(' ', '_')});
    }
  })
  return categories;
}

function getData(categories) {
  var dfd = $.Deferred();

  var promises = [];
  $(categories).each(function() {
    promises.push($.getJSON(this.url + '.json?callback=?'));
  })

  $.when.apply($, promises).then(function() {
    if(promises.length > 1) {
      dfd.resolve(arguments);
    } else {
      dfd.resolve([arguments]);
    }
  });

  return dfd;
}

var categories = getCategories(asset);
categories.splice(0,0,{mediaType: "This Event", url: 'http://localhost:3000/event/' + asset.assetName });
var ajax = getData(categories);

ajax.done(function(data) {
  var html = '<div id="extract" style="position:absolute;left:0;top:0;border:solid 2px black;background-color:white;z-index:1000;width:auto;padding:5px">';

  for(var i = 0; i < data.length; i++) {
    html += '<div style="float:left;margin:10px;"><h5>' + categories[i].mediaType + '</h5>';
    var showEvent = true;
    if(categories[i].mediaType == "This Event") {
      showEvent = false;
    }
    for(var j = 0; j < data[i][0].length; j++) {
      var item = data[i][0][j];
      var time = item.result_time.split('T')[1].substring(0,8);
      html += '<p>' + time;
      if(showEvent) {
        html += ' at ' + item.event_name;
      }
      html += '</p>';

      if(j == 9) {
        break;
      }
    }
    html += '</div>';
  }
  html += '<p><a href="#" onclick="$(\'#extract\').remove();return false;">Close</a></p></div>';

  $('body').append(html);
})

