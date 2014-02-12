(function(cordova){

    'use strict';

    var exports = {},method;

    var uid = 0;
    var tabTags = [];

    var getColorAsFloat = function(color){
        return color / 255.0;
    };

    var getColorStringFromArray = function(color) {
        if (!color) {
            return null;
        }
        return getColorAsFloat(color[0]) + ',' + getColorAsFloat(color[1]) + ',' + getColorAsFloat(color[2]) + ',' + (color[3] || 1.0);
    };

    var plugin = {
        name:'TabBar',
        api:{
            'setup':function(options) {

                if (!options){options = {};}

                var tintDefault = getColorStringFromArray(options.tintDefault);
                var tintSelected = getColorStringFromArray(options.tintSelected);

                console.log(tintDefault,tintSelected);

                return {
                    params:[tintDefault,tintSelected],
                    success:null,
                    failure:null
                }
            },
            'addTab':function(id,title,icon,ontap) {

                tabTags[id] = uid++;

                return {
                    params:[tabTags[id],title,icon],
                    success:ontap || null,
                    failure:null
                };
            }
        }
    };

    for (method in plugin.api) {

        if (!plugin.api.hasOwnProperty(method)){continue;}

        exports[method] = (function(name,setup){

            return function() {

                var config = setup ? setup.apply(this,arguments) : {};

                cordova.exec(
                    config.success || null,
                    config.failure || null,
                    plugin.name,
                    name,
                    config.params || []
                );

            };

            /*
            return function() {

                cordova.exec(
                    props.success,
                    props.failure,
                    plugin.name,
                    method,
                    props.method ? props.method.apply(this,options) : []
                );

            };
            */

        }(method,plugin.api[method]));

    }

    // expose
    if (!window.plugins) {window.plugins = {};}
    window.plugins[plugin.name.charAt(0).toLowerCase() + plugin.name.slice(1)] = exports;

}(window.cordova));