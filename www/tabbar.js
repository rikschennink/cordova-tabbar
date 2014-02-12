(function(cordova){

    'use strict';

    var exports = {},method;

    var getColorAsFloat = function(color){
        return color / 255.0;
    };

    var getColorStringFromArray = function(color) {
        return color ? getColorAsFloat(color[0]) + ',' + getColorAsFloat(color[1]) + ',' + getColorAsFloat(color[2]) + ',' + (color[3] || 1.0) : null;
    };

    var plugin = {
        name:'TabBar',
        api:{
            'reset':function(){
                return null;
            },
            'setup':function(options) {

                if (!options){options = {};}

                var tintDefault = getColorStringFromArray(options.tintDefault);
                var tintSelected = getColorStringFromArray(options.tintSelected);

                return {
                    params:[tintDefault,tintSelected]
                }
            },
            'addTab':function(id,title,icon,ontap) {

                return {
                    params:[id,title,icon],
                    success:ontap || null
                };

            },
            'selectTab':function(id) {
                return {
                    params:[id]
                }
            }
        }
    };

    for (method in plugin.api) {

        if (!plugin.api.hasOwnProperty(method)){continue;}

        exports[method] = (function(name,setup){

            return function() {

                var config = setup ? setup.apply(this,arguments) || {} : {};

                cordova.exec(
                    config.success || null,
                    config.failure || null,
                    plugin.name,
                    name,
                    config.params || []
                );

            };
        }(method,plugin.api[method]));

    }

    // expose
    if (!window.plugins) {window.plugins = {};}
    window.plugins[plugin.name.charAt(0).toLowerCase() + plugin.name.slice(1)] = exports;

}(window.cordova));