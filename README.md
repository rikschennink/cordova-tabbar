# Cordova iOS TabBar

Native **iOS** TabBar for Cordova

Currently in development

## Methods

The following methods are exposed on `window.plugins.TabBar`.

Setup TabBar
```javascript
/*
options: {
    tintDefault:[255,0,0,.5], // not implemented yet
    tintSelected:[255,0,0,.5],
}
*/
setup(options)
```

Add Tab to TabBar
```javascript
/*
id:         unique id
title:      title to show beneath tab
icon:       icon (without extension, should be png, also @2x is auto added)
callback:   function executed when user taps the tab
*/
addTab(id,title,icon,callback);
```

Reset TabBar
```javascript
reset()
```

Select Tab
```javascript
id: id of tab to set to selected state
selectTab(id)
```