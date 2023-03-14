/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "http://localhost:3000/packs/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./app/javascript/packs/application.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./app/javascript/packs/application.js":
/*!*********************************************!*\
  !*** ./app/javascript/packs/application.js ***!
  \*********************************************/
/*! no exports provided */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _sixoverground_tang__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @sixoverground/tang */ "./node_modules/@sixoverground/tang/lib/js/index.js");
/* harmony import */ var _sixoverground_tang_lib_css_main_css__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @sixoverground/tang/lib/css/main.css */ "./node_modules/@sixoverground/tang/lib/css/main.css");
/* harmony import */ var _sixoverground_tang_lib_css_main_css__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_sixoverground_tang_lib_css_main_css__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var jquery_ujs__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! jquery-ujs */ "./node_modules/jquery-ujs/src/rails.js");
/* harmony import */ var jquery_ujs__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(jquery_ujs__WEBPACK_IMPORTED_MODULE_2__);
/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)



console.log('Hello World from Webpacker 1');
Object(_sixoverground_tang__WEBPACK_IMPORTED_MODULE_0__["default"])();

/***/ }),

/***/ "./node_modules/@sixoverground/tang/lib/css/main.css":
/*!***********************************************************!*\
  !*** ./node_modules/@sixoverground/tang/lib/css/main.css ***!
  \***********************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

var api = __webpack_require__(/*! ../../../../style-loader/dist/runtime/injectStylesIntoStyleTag.js */ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js");
            var content = __webpack_require__(/*! !../../../../css-loader/dist/cjs.js??ref--5-1!../../../../postcss-loader/src??ref--5-2!./main.css */ "./node_modules/css-loader/dist/cjs.js?!./node_modules/postcss-loader/src/index.js?!./node_modules/@sixoverground/tang/lib/css/main.css");

            content = content.__esModule ? content.default : content;

            if (typeof content === 'string') {
              content = [[module.i, content, '']];
            }

var options = {};

options.insert = "head";
options.singleton = false;

var update = api(content, options);



module.exports = content.locals || {};

/***/ }),

/***/ "./node_modules/@sixoverground/tang/lib/js/index.js":
/*!**********************************************************!*\
  !*** ./node_modules/@sixoverground/tang/lib/js/index.js ***!
  \**********************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
// Create a Stripe client.
// var stripe = Stripe(process.env.STRIPE_PUBLISHABLE_KEY);
var stripe = Stripe(window.Tang.STRIPE_PUBLISHABLE_KEY);

const registerElements = () => {
  if (!document.getElementById('card-element')) {
    return;
  } // Create an instance of Elements.


  var elements = stripe.elements(); // Custom styling can be passed to options when creating an Element.
  // (Note that this demo uses a wider set of styles than the guide below.)

  var style = {
    base: {
      color: '#32325d',
      fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
      fontSmoothing: 'antialiased',
      fontSize: '16px',
      '::placeholder': {
        color: '#aab7c4'
      }
    },
    invalid: {
      color: '#fa755a',
      iconColor: '#fa755a'
    }
  }; // Create an instance of the card Element.

  var card = elements.create('card', {
    style: style
  }); // Add an instance of the card Element into the `card-element` <div>.

  card.mount('#card-element'); // Handle real-time validation errors from the card Element.

  card.on('change', function (event) {
    var displayError = document.getElementById('card-errors');

    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  }); // Handle form submission.

  var form = document.getElementById('payment-form');
  form.addEventListener('submit', function (event) {
    event.preventDefault();
    const name = form.querySelector('#name'); // const zip = form.querySelector('#zip')

    const additionalData = {
      name: name ? name.value : undefined // address_zip: zip ? zip.value : undefined

    };
    stripe.createToken(card, additionalData).then(function (result) {
      if (result.error) {
        // Inform the user if there was an error.
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        // Send the token to your server.
        stripeTokenHandler(result.token);
      }
    });
  }); // Submit the form with the token ID.

  function stripeTokenHandler(token) {
    // Insert the token ID into the form so it gets submitted to the server
    var form = document.getElementById('payment-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripe_token');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput); // Submit the form

    form.submit();
  }
};

/* harmony default export */ __webpack_exports__["default"] = (registerElements);

/***/ }),

/***/ "./node_modules/css-loader/dist/cjs.js?!./node_modules/postcss-loader/src/index.js?!./node_modules/@sixoverground/tang/lib/css/main.css":
/*!*******************************************************************************************************************************************************!*\
  !*** ./node_modules/css-loader/dist/cjs.js??ref--5-1!./node_modules/postcss-loader/src??ref--5-2!./node_modules/@sixoverground/tang/lib/css/main.css ***!
  \*******************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

// Imports
var ___CSS_LOADER_API_IMPORT___ = __webpack_require__(/*! ../../../../css-loader/dist/runtime/api.js */ "./node_modules/css-loader/dist/runtime/api.js");
exports = ___CSS_LOADER_API_IMPORT___(true);
// Module
exports.push([module.i, "/**\n * The CSS shown here will not be introduced in the Quickstart guide, but shows\n * how you can use CSS to style your Element's container.\n */\n .StripeElement {\n  box-sizing: border-box;\n\n  height: 40px;\n\n  padding: 10px 12px;\n\n  border: 1px solid transparent;\n  border-radius: 4px;\n  background-color: white;\n\n  box-shadow: 0 1px 3px 0 #e6ebf1;\n  transition: box-shadow 150ms ease;\n}\n .StripeElement--focus {\n    box-shadow: 0 1px 3px 0 #cfd7df;\n  }\n .StripeElement--invalid {\n    border-color: #fa755a;\n  }\n .StripeElement--webkit-autofill {\n    background-color: #fefde5 !important;\n  }", "",{"version":3,"sources":["main.css"],"names":[],"mappings":"AAAA;;;EAGE;CACD;EACC,sBAAsB;;EAEtB,YAAY;;EAEZ,kBAAkB;;EAElB,6BAA6B;EAC7B,kBAAkB;EAClB,uBAAuB;;EAEvB,+BAA+B;EAE/B,iCAAiC;AACnC;CAEE;IACE,+BAA+B;EACjC;CAEA;IACE,qBAAqB;EACvB;CAEA;IACE,oCAAoC;EACtC","file":"main.css","sourcesContent":["/**\n * The CSS shown here will not be introduced in the Quickstart guide, but shows\n * how you can use CSS to style your Element's container.\n */\n .StripeElement {\n  box-sizing: border-box;\n\n  height: 40px;\n\n  padding: 10px 12px;\n\n  border: 1px solid transparent;\n  border-radius: 4px;\n  background-color: white;\n\n  box-shadow: 0 1px 3px 0 #e6ebf1;\n  -webkit-transition: box-shadow 150ms ease;\n  transition: box-shadow 150ms ease;\n}\n  \n  .StripeElement--focus {\n    box-shadow: 0 1px 3px 0 #cfd7df;\n  }\n  \n  .StripeElement--invalid {\n    border-color: #fa755a;\n  }\n  \n  .StripeElement--webkit-autofill {\n    background-color: #fefde5 !important;\n  }"]}]);
// Exports
module.exports = exports;


/***/ }),

/***/ "./node_modules/css-loader/dist/runtime/api.js":
/*!*****************************************************!*\
  !*** ./node_modules/css-loader/dist/runtime/api.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

/*
  MIT License http://www.opensource.org/licenses/mit-license.php
  Author Tobias Koppers @sokra
*/
// css base code, injected by the css-loader
// eslint-disable-next-line func-names

module.exports = function (useSourceMap) {
  var list = []; // return the list of modules as css string

  list.toString = function toString() {
    return this.map(function (item) {
      var content = cssWithMappingToString(item, useSourceMap);

      if (item[2]) {
        return "@media ".concat(item[2], " {").concat(content, "}");
      }

      return content;
    }).join('');
  }; // import a list of modules into the list
  // eslint-disable-next-line func-names


  list.i = function (modules, mediaQuery, dedupe) {
    if (typeof modules === 'string') {
      // eslint-disable-next-line no-param-reassign
      modules = [[null, modules, '']];
    }

    var alreadyImportedModules = {};

    if (dedupe) {
      for (var i = 0; i < this.length; i++) {
        // eslint-disable-next-line prefer-destructuring
        var id = this[i][0];

        if (id != null) {
          alreadyImportedModules[id] = true;
        }
      }
    }

    for (var _i = 0; _i < modules.length; _i++) {
      var item = [].concat(modules[_i]);

      if (dedupe && alreadyImportedModules[item[0]]) {
        // eslint-disable-next-line no-continue
        continue;
      }

      if (mediaQuery) {
        if (!item[2]) {
          item[2] = mediaQuery;
        } else {
          item[2] = "".concat(mediaQuery, " and ").concat(item[2]);
        }
      }

      list.push(item);
    }
  };

  return list;
};

function cssWithMappingToString(item, useSourceMap) {
  var content = item[1] || ''; // eslint-disable-next-line prefer-destructuring

  var cssMapping = item[3];

  if (!cssMapping) {
    return content;
  }

  if (useSourceMap && typeof btoa === 'function') {
    var sourceMapping = toComment(cssMapping);
    var sourceURLs = cssMapping.sources.map(function (source) {
      return "/*# sourceURL=".concat(cssMapping.sourceRoot || '').concat(source, " */");
    });
    return [content].concat(sourceURLs).concat([sourceMapping]).join('\n');
  }

  return [content].join('\n');
} // Adapted from convert-source-map (MIT)


function toComment(sourceMap) {
  // eslint-disable-next-line no-undef
  var base64 = btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap))));
  var data = "sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(base64);
  return "/*# ".concat(data, " */");
}

/***/ }),

/***/ "./node_modules/jquery-ujs/src/rails.js":
/*!**********************************************!*\
  !*** ./node_modules/jquery-ujs/src/rails.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

/* jshint node: true */

/**
 * Unobtrusive scripting adapter for jQuery
 * https://github.com/rails/jquery-ujs
 *
 * Requires jQuery 1.8.0 or later.
 *
 * Released under the MIT license
 *
 */
(function () {
  'use strict';

  var jqueryUjsInit = function ($, undefined) {
    // Cut down on the number of issues from people inadvertently including jquery_ujs twice
    // by detecting and raising an error when it happens.
    if ($.rails !== undefined) {
      $.error('jquery-ujs has already been loaded!');
    } // Shorthand to make it a little easier to call public rails functions from within rails.js


    var rails;
    var $document = $(document);
    $.rails = rails = {
      // Link elements bound by jquery-ujs
      linkClickSelector: 'a[data-confirm], a[data-method], a[data-remote]:not([disabled]), a[data-disable-with], a[data-disable]',
      // Button elements bound by jquery-ujs
      buttonClickSelector: 'button[data-remote]:not([form]):not(form button), button[data-confirm]:not([form]):not(form button)',
      // Select elements bound by jquery-ujs
      inputChangeSelector: 'select[data-remote], input[data-remote], textarea[data-remote]',
      // Form elements bound by jquery-ujs
      formSubmitSelector: 'form:not([data-turbo=true])',
      // Form input elements bound by jquery-ujs
      formInputClickSelector: 'form:not([data-turbo=true]) input[type=submit], form:not([data-turbo=true]) input[type=image], form:not([data-turbo=true]) button[type=submit], form:not([data-turbo=true]) button:not([type]), input[type=submit][form], input[type=image][form], button[type=submit][form], button[form]:not([type])',
      // Form input elements disabled during form submission
      disableSelector: 'input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled, input[data-disable]:enabled, button[data-disable]:enabled, textarea[data-disable]:enabled',
      // Form input elements re-enabled after form submission
      enableSelector: 'input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled, input[data-disable]:disabled, button[data-disable]:disabled, textarea[data-disable]:disabled',
      // Form required input elements
      requiredInputSelector: 'input[name][required]:not([disabled]), textarea[name][required]:not([disabled])',
      // Form file input elements
      fileInputSelector: 'input[name][type=file]:not([disabled])',
      // Link onClick disable selector with possible reenable after remote submission
      linkDisableSelector: 'a[data-disable-with], a[data-disable]',
      // Button onClick disable selector with possible reenable after remote submission
      buttonDisableSelector: 'button[data-remote][data-disable-with], button[data-remote][data-disable]',
      // Up-to-date Cross-Site Request Forgery token
      csrfToken: function () {
        return $('meta[name=csrf-token]').attr('content');
      },
      // URL param that must contain the CSRF token
      csrfParam: function () {
        return $('meta[name=csrf-param]').attr('content');
      },
      // Make sure that every Ajax request sends the CSRF token
      CSRFProtection: function (xhr) {
        var token = rails.csrfToken();
        if (token) xhr.setRequestHeader('X-CSRF-Token', token);
      },
      // Make sure that all forms have actual up-to-date tokens (cached forms contain old ones)
      refreshCSRFTokens: function () {
        $('form input[name="' + rails.csrfParam() + '"]').val(rails.csrfToken());
      },
      // Triggers an event on an element and returns false if the event result is false
      fire: function (obj, name, data) {
        var event = $.Event(name);
        obj.trigger(event, data);
        return event.result !== false;
      },
      // Default confirm dialog, may be overridden with custom confirm dialog in $.rails.confirm
      confirm: function (message) {
        return confirm(message);
      },
      // Default ajax function, may be overridden with custom function in $.rails.ajax
      ajax: function (options) {
        return $.ajax(options);
      },
      // Default way to get an element's href. May be overridden at $.rails.href.
      href: function (element) {
        return element[0].href;
      },
      // Checks "data-remote" if true to handle the request through a XHR request.
      isRemote: function (element) {
        return element.data('remote') !== undefined && element.data('remote') !== false;
      },
      // Submits "remote" forms and links with ajax
      handleRemote: function (element) {
        var method, url, data, withCredentials, dataType, options;

        if (rails.fire(element, 'ajax:before')) {
          withCredentials = element.data('with-credentials') || null;
          dataType = element.data('type') || $.ajaxSettings && $.ajaxSettings.dataType;

          if (element.is('form')) {
            method = element.data('ujs:submit-button-formmethod') || element.attr('method');
            url = element.data('ujs:submit-button-formaction') || element.attr('action');
            data = $(element[0]).serializeArray(); // memoized value from clicked submit button

            var button = element.data('ujs:submit-button');

            if (button) {
              data.push(button);
              element.data('ujs:submit-button', null);
            }

            element.data('ujs:submit-button-formmethod', null);
            element.data('ujs:submit-button-formaction', null);
          } else if (element.is(rails.inputChangeSelector)) {
            method = element.data('method');
            url = element.data('url');
            data = element.serialize();
            if (element.data('params')) data = data + '&' + element.data('params');
          } else if (element.is(rails.buttonClickSelector)) {
            method = element.data('method') || 'get';
            url = element.data('url');
            data = element.serialize();
            if (element.data('params')) data = data + '&' + element.data('params');
          } else {
            method = element.data('method');
            url = rails.href(element);
            data = element.data('params') || null;
          }

          options = {
            type: method || 'GET',
            data: data,
            dataType: dataType,
            // stopping the "ajax:beforeSend" event will cancel the ajax request
            beforeSend: function (xhr, settings) {
              if (settings.dataType === undefined) {
                xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
              }

              if (rails.fire(element, 'ajax:beforeSend', [xhr, settings])) {
                element.trigger('ajax:send', xhr);
              } else {
                return false;
              }
            },
            success: function (data, status, xhr) {
              element.trigger('ajax:success', [data, status, xhr]);
            },
            complete: function (xhr, status) {
              element.trigger('ajax:complete', [xhr, status]);
            },
            error: function (xhr, status, error) {
              element.trigger('ajax:error', [xhr, status, error]);
            },
            crossDomain: rails.isCrossDomain(url)
          }; // There is no withCredentials for IE6-8 when
          // "Enable native XMLHTTP support" is disabled

          if (withCredentials) {
            options.xhrFields = {
              withCredentials: withCredentials
            };
          } // Only pass url to `ajax` options if not blank


          if (url) {
            options.url = url;
          }

          return rails.ajax(options);
        } else {
          return false;
        }
      },
      // Determines if the request is a cross domain request.
      isCrossDomain: function (url) {
        var originAnchor = document.createElement('a');
        originAnchor.href = location.href;
        var urlAnchor = document.createElement('a');

        try {
          urlAnchor.href = url; // This is a workaround to a IE bug.

          urlAnchor.href = urlAnchor.href; // If URL protocol is false or is a string containing a single colon
          // *and* host are false, assume it is not a cross-domain request
          // (should only be the case for IE7 and IE compatibility mode).
          // Otherwise, evaluate protocol and host of the URL against the origin
          // protocol and host.

          return !((!urlAnchor.protocol || urlAnchor.protocol === ':') && !urlAnchor.host || originAnchor.protocol + '//' + originAnchor.host === urlAnchor.protocol + '//' + urlAnchor.host);
        } catch (e) {
          // If there is an error parsing the URL, assume it is crossDomain.
          return true;
        }
      },
      // Handles "data-method" on links such as:
      // <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
      handleMethod: function (link) {
        var href = rails.href(link),
            method = link.data('method'),
            target = link.attr('target'),
            csrfToken = rails.csrfToken(),
            csrfParam = rails.csrfParam(),
            form = $('<form method="post" action="' + href + '"></form>'),
            metadataInput = '<input name="_method" value="' + method + '" type="hidden" />';

        if (csrfParam !== undefined && csrfToken !== undefined && !rails.isCrossDomain(href)) {
          metadataInput += '<input name="' + csrfParam + '" value="' + csrfToken + '" type="hidden" />';
        }

        if (target) {
          form.attr('target', target);
        }

        form.hide().append(metadataInput).appendTo('body');
        form.submit();
      },
      // Helper function that returns form elements that match the specified CSS selector
      // If form is actually a "form" element this will return associated elements outside the from that have
      // the html form attribute set
      formElements: function (form, selector) {
        return form.is('form') ? $(form[0].elements).filter(selector) : form.find(selector);
      },

      /* Disables form elements:
        - Caches element value in 'ujs:enable-with' data store
        - Replaces element text with value of 'data-disable-with' attribute
        - Sets disabled property to true
      */
      disableFormElements: function (form) {
        rails.formElements(form, rails.disableSelector).each(function () {
          rails.disableFormElement($(this));
        });
      },
      disableFormElement: function (element) {
        var method, replacement;
        method = element.is('button') ? 'html' : 'val';
        replacement = element.data('disable-with');

        if (replacement !== undefined) {
          element.data('ujs:enable-with', element[method]());
          element[method](replacement);
        }

        element.prop('disabled', true);
        element.data('ujs:disabled', true);
      },

      /* Re-enables disabled form elements:
        - Replaces element text with cached value from 'ujs:enable-with' data store (created in `disableFormElements`)
        - Sets disabled property to false
      */
      enableFormElements: function (form) {
        rails.formElements(form, rails.enableSelector).each(function () {
          rails.enableFormElement($(this));
        });
      },
      enableFormElement: function (element) {
        var method = element.is('button') ? 'html' : 'val';

        if (element.data('ujs:enable-with') !== undefined) {
          element[method](element.data('ujs:enable-with'));
          element.removeData('ujs:enable-with'); // clean up cache
        }

        element.prop('disabled', false);
        element.removeData('ujs:disabled');
      },

      /* For 'data-confirm' attribute:
         - Fires `confirm` event
         - Shows the confirmation dialog
         - Fires the `confirm:complete` event
          Returns `true` if no function stops the chain and user chose yes; `false` otherwise.
         Attaching a handler to the element's `confirm` event that returns a `falsy` value cancels the confirmation dialog.
         Attaching a handler to the element's `confirm:complete` event that returns a `falsy` value makes this function
         return false. The `confirm:complete` event is fired whether or not the user answered true or false to the dialog.
      */
      allowAction: function (element) {
        var message = element.data('confirm'),
            answer = false,
            callback;

        if (!message) {
          return true;
        }

        if (rails.fire(element, 'confirm')) {
          try {
            answer = rails.confirm(message);
          } catch (e) {
            (console.error || console.log).call(console, e.stack || e);
          }

          callback = rails.fire(element, 'confirm:complete', [answer]);
        }

        return answer && callback;
      },
      // Helper function which checks for blank inputs in a form that match the specified CSS selector
      blankInputs: function (form, specifiedSelector, nonBlank) {
        var foundInputs = $(),
            input,
            valueToCheck,
            radiosForNameWithNoneSelected,
            radioName,
            selector = specifiedSelector || 'input,textarea',
            requiredInputs = form.find(selector),
            checkedRadioButtonNames = {};
        requiredInputs.each(function () {
          input = $(this);

          if (input.is('input[type=radio]')) {
            // Don't count unchecked required radio as blank if other radio with same name is checked,
            // regardless of whether same-name radio input has required attribute or not. The spec
            // states https://www.w3.org/TR/html5/forms.html#the-required-attribute
            radioName = input.attr('name'); // Skip if we've already seen the radio with this name.

            if (!checkedRadioButtonNames[radioName]) {
              // If none checked
              if (form.find('input[type=radio]:checked[name="' + radioName + '"]').length === 0) {
                radiosForNameWithNoneSelected = form.find('input[type=radio][name="' + radioName + '"]');
                foundInputs = foundInputs.add(radiosForNameWithNoneSelected);
              } // We only need to check each name once.


              checkedRadioButtonNames[radioName] = radioName;
            }
          } else {
            valueToCheck = input.is('input[type=checkbox],input[type=radio]') ? input.is(':checked') : !!input.val();

            if (valueToCheck === nonBlank) {
              foundInputs = foundInputs.add(input);
            }
          }
        });
        return foundInputs.length ? foundInputs : false;
      },
      // Helper function which checks for non-blank inputs in a form that match the specified CSS selector
      nonBlankInputs: function (form, specifiedSelector) {
        return rails.blankInputs(form, specifiedSelector, true); // true specifies nonBlank
      },
      // Helper function, needed to provide consistent behavior in IE
      stopEverything: function (e) {
        $(e.target).trigger('ujs:everythingStopped');
        e.stopImmediatePropagation();
        return false;
      },
      //  Replace element's html with the 'data-disable-with' after storing original html
      //  and prevent clicking on it
      disableElement: function (element) {
        var replacement = element.data('disable-with');

        if (replacement !== undefined) {
          element.data('ujs:enable-with', element.html()); // store enabled state

          element.html(replacement);
        }

        element.on('click.railsDisable', function (e) {
          // prevent further clicking
          return rails.stopEverything(e);
        });
        element.data('ujs:disabled', true);
      },
      // Restore element to its original state which was disabled by 'disableElement' above
      enableElement: function (element) {
        if (element.data('ujs:enable-with') !== undefined) {
          element.html(element.data('ujs:enable-with')); // set to old enabled state

          element.removeData('ujs:enable-with'); // clean up cache
        }

        element.off('click.railsDisable'); // enable element

        element.removeData('ujs:disabled');
      }
    };

    if (rails.fire($document, 'rails:attachBindings')) {
      $.ajaxPrefilter(function (options, originalOptions, xhr) {
        if (!options.crossDomain) {
          rails.CSRFProtection(xhr);
        }
      }); // This event works the same as the load event, except that it fires every
      // time the page is loaded.
      //
      // See https://github.com/rails/jquery-ujs/issues/357
      // See https://developer.mozilla.org/en-US/docs/Using_Firefox_1.5_caching

      $(window).on('pageshow.rails', function () {
        $($.rails.enableSelector).each(function () {
          var element = $(this);

          if (element.data('ujs:disabled')) {
            $.rails.enableFormElement(element);
          }
        });
        $($.rails.linkDisableSelector).each(function () {
          var element = $(this);

          if (element.data('ujs:disabled')) {
            $.rails.enableElement(element);
          }
        });
      });
      $document.on('ajax:complete', rails.linkDisableSelector, function () {
        rails.enableElement($(this));
      });
      $document.on('ajax:complete', rails.buttonDisableSelector, function () {
        rails.enableFormElement($(this));
      });
      $document.on('click.rails', rails.linkClickSelector, function (e) {
        var link = $(this),
            method = link.data('method'),
            data = link.data('params'),
            metaClick = e.metaKey || e.ctrlKey;
        if (!rails.allowAction(link)) return rails.stopEverything(e);
        if (!metaClick && link.is(rails.linkDisableSelector)) rails.disableElement(link);

        if (rails.isRemote(link)) {
          if (metaClick && (!method || method === 'GET') && !data) {
            return true;
          }

          var handleRemote = rails.handleRemote(link); // Response from rails.handleRemote() will either be false or a deferred object promise.

          if (handleRemote === false) {
            rails.enableElement(link);
          } else {
            handleRemote.fail(function () {
              rails.enableElement(link);
            });
          }

          return false;
        } else if (method) {
          rails.handleMethod(link);
          return false;
        }
      });
      $document.on('click.rails', rails.buttonClickSelector, function (e) {
        var button = $(this);
        if (!rails.allowAction(button) || !rails.isRemote(button)) return rails.stopEverything(e);
        if (button.is(rails.buttonDisableSelector)) rails.disableFormElement(button);
        var handleRemote = rails.handleRemote(button); // Response from rails.handleRemote() will either be false or a deferred object promise.

        if (handleRemote === false) {
          rails.enableFormElement(button);
        } else {
          handleRemote.fail(function () {
            rails.enableFormElement(button);
          });
        }

        return false;
      });
      $document.on('change.rails', rails.inputChangeSelector, function (e) {
        var link = $(this);
        if (!rails.allowAction(link) || !rails.isRemote(link)) return rails.stopEverything(e);
        rails.handleRemote(link);
        return false;
      });
      $document.on('submit.rails', rails.formSubmitSelector, function (e) {
        var form = $(this),
            remote = rails.isRemote(form),
            blankRequiredInputs,
            nonBlankFileInputs;
        if (!rails.allowAction(form)) return rails.stopEverything(e); // Skip other logic when required values are missing or file upload is present

        if (form.attr('novalidate') === undefined) {
          if (form.data('ujs:formnovalidate-button') === undefined) {
            blankRequiredInputs = rails.blankInputs(form, rails.requiredInputSelector, false);

            if (blankRequiredInputs && rails.fire(form, 'ajax:aborted:required', [blankRequiredInputs])) {
              return rails.stopEverything(e);
            }
          } else {
            // Clear the formnovalidate in case the next button click is not on a formnovalidate button
            // Not strictly necessary to do here, since it is also reset on each button click, but just to be certain
            form.data('ujs:formnovalidate-button', undefined);
          }
        }

        if (remote) {
          nonBlankFileInputs = rails.nonBlankInputs(form, rails.fileInputSelector);

          if (nonBlankFileInputs) {
            // Slight timeout so that the submit button gets properly serialized
            // (make it easy for event handler to serialize form without disabled values)
            setTimeout(function () {
              rails.disableFormElements(form);
            }, 13);
            var aborted = rails.fire(form, 'ajax:aborted:file', [nonBlankFileInputs]); // Re-enable form elements if event bindings return false (canceling normal form submission)

            if (!aborted) {
              setTimeout(function () {
                rails.enableFormElements(form);
              }, 13);
            }

            return aborted;
          }

          rails.handleRemote(form);
          return false;
        } else {
          // Slight timeout so that the submit button gets properly serialized
          setTimeout(function () {
            rails.disableFormElements(form);
          }, 13);
        }
      });
      $document.on('click.rails', rails.formInputClickSelector, function (event) {
        var button = $(this);
        if (!rails.allowAction(button)) return rails.stopEverything(event); // Register the pressed submit button

        var name = button.attr('name'),
            data = name ? {
          name: name,
          value: button.val()
        } : null;
        var form = button.closest('form');

        if (form.length === 0) {
          form = $('#' + button.attr('form'));
        }

        form.data('ujs:submit-button', data); // Save attributes from button

        form.data('ujs:formnovalidate-button', button.attr('formnovalidate'));
        form.data('ujs:submit-button-formaction', button.attr('formaction'));
        form.data('ujs:submit-button-formmethod', button.attr('formmethod'));
      });
      $document.on('ajax:send.rails', rails.formSubmitSelector, function (event) {
        if (this === event.target) rails.disableFormElements($(this));
      });
      $document.on('ajax:complete.rails', rails.formSubmitSelector, function (event) {
        if (this === event.target) rails.enableFormElements($(this));
      });
      $(function () {
        rails.refreshCSRFTokens();
      });
    }
  };

  if (window.jQuery) {
    jqueryUjsInit(jQuery);
  } else if (true) {
    module.exports = jqueryUjsInit;
  }
})();

/***/ }),

/***/ "./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js":
/*!****************************************************************************!*\
  !*** ./node_modules/style-loader/dist/runtime/injectStylesIntoStyleTag.js ***!
  \****************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var isOldIE = function isOldIE() {
  var memo;
  return function memorize() {
    if (typeof memo === 'undefined') {
      // Test for IE <= 9 as proposed by Browserhacks
      // @see http://browserhacks.com/#hack-e71d8692f65334173fee715c222cb805
      // Tests for existence of standard globals is to allow style-loader
      // to operate correctly into non-standard environments
      // @see https://github.com/webpack-contrib/style-loader/issues/177
      memo = Boolean(window && document && document.all && !window.atob);
    }

    return memo;
  };
}();

var getTarget = function getTarget() {
  var memo = {};
  return function memorize(target) {
    if (typeof memo[target] === 'undefined') {
      var styleTarget = document.querySelector(target); // Special case to return head of iframe instead of iframe itself

      if (window.HTMLIFrameElement && styleTarget instanceof window.HTMLIFrameElement) {
        try {
          // This will throw an exception if access to iframe is blocked
          // due to cross-origin restrictions
          styleTarget = styleTarget.contentDocument.head;
        } catch (e) {
          // istanbul ignore next
          styleTarget = null;
        }
      }

      memo[target] = styleTarget;
    }

    return memo[target];
  };
}();

var stylesInDom = [];

function getIndexByIdentifier(identifier) {
  var result = -1;

  for (var i = 0; i < stylesInDom.length; i++) {
    if (stylesInDom[i].identifier === identifier) {
      result = i;
      break;
    }
  }

  return result;
}

function modulesToDom(list, options) {
  var idCountMap = {};
  var identifiers = [];

  for (var i = 0; i < list.length; i++) {
    var item = list[i];
    var id = options.base ? item[0] + options.base : item[0];
    var count = idCountMap[id] || 0;
    var identifier = "".concat(id, " ").concat(count);
    idCountMap[id] = count + 1;
    var index = getIndexByIdentifier(identifier);
    var obj = {
      css: item[1],
      media: item[2],
      sourceMap: item[3]
    };

    if (index !== -1) {
      stylesInDom[index].references++;
      stylesInDom[index].updater(obj);
    } else {
      stylesInDom.push({
        identifier: identifier,
        updater: addStyle(obj, options),
        references: 1
      });
    }

    identifiers.push(identifier);
  }

  return identifiers;
}

function insertStyleElement(options) {
  var style = document.createElement('style');
  var attributes = options.attributes || {};

  if (typeof attributes.nonce === 'undefined') {
    var nonce =  true ? __webpack_require__.nc : undefined;

    if (nonce) {
      attributes.nonce = nonce;
    }
  }

  Object.keys(attributes).forEach(function (key) {
    style.setAttribute(key, attributes[key]);
  });

  if (typeof options.insert === 'function') {
    options.insert(style);
  } else {
    var target = getTarget(options.insert || 'head');

    if (!target) {
      throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");
    }

    target.appendChild(style);
  }

  return style;
}

function removeStyleElement(style) {
  // istanbul ignore if
  if (style.parentNode === null) {
    return false;
  }

  style.parentNode.removeChild(style);
}
/* istanbul ignore next  */


var replaceText = function replaceText() {
  var textStore = [];
  return function replace(index, replacement) {
    textStore[index] = replacement;
    return textStore.filter(Boolean).join('\n');
  };
}();

function applyToSingletonTag(style, index, remove, obj) {
  var css = remove ? '' : obj.media ? "@media ".concat(obj.media, " {").concat(obj.css, "}") : obj.css; // For old IE

  /* istanbul ignore if  */

  if (style.styleSheet) {
    style.styleSheet.cssText = replaceText(index, css);
  } else {
    var cssNode = document.createTextNode(css);
    var childNodes = style.childNodes;

    if (childNodes[index]) {
      style.removeChild(childNodes[index]);
    }

    if (childNodes.length) {
      style.insertBefore(cssNode, childNodes[index]);
    } else {
      style.appendChild(cssNode);
    }
  }
}

function applyToTag(style, options, obj) {
  var css = obj.css;
  var media = obj.media;
  var sourceMap = obj.sourceMap;

  if (media) {
    style.setAttribute('media', media);
  } else {
    style.removeAttribute('media');
  }

  if (sourceMap && typeof btoa !== 'undefined') {
    css += "\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(sourceMap)))), " */");
  } // For old IE

  /* istanbul ignore if  */


  if (style.styleSheet) {
    style.styleSheet.cssText = css;
  } else {
    while (style.firstChild) {
      style.removeChild(style.firstChild);
    }

    style.appendChild(document.createTextNode(css));
  }
}

var singleton = null;
var singletonCounter = 0;

function addStyle(obj, options) {
  var style;
  var update;
  var remove;

  if (options.singleton) {
    var styleIndex = singletonCounter++;
    style = singleton || (singleton = insertStyleElement(options));
    update = applyToSingletonTag.bind(null, style, styleIndex, false);
    remove = applyToSingletonTag.bind(null, style, styleIndex, true);
  } else {
    style = insertStyleElement(options);
    update = applyToTag.bind(null, style, options);

    remove = function remove() {
      removeStyleElement(style);
    };
  }

  update(obj);
  return function updateStyle(newObj) {
    if (newObj) {
      if (newObj.css === obj.css && newObj.media === obj.media && newObj.sourceMap === obj.sourceMap) {
        return;
      }

      update(obj = newObj);
    } else {
      remove();
    }
  };
}

module.exports = function (list, options) {
  options = options || {}; // Force single-tag solution on IE6-9, which has a hard limit on the # of <style>
  // tags it will allow on a page

  if (!options.singleton && typeof options.singleton !== 'boolean') {
    options.singleton = isOldIE();
  }

  list = list || [];
  var lastIdentifiers = modulesToDom(list, options);
  return function update(newList) {
    newList = newList || [];

    if (Object.prototype.toString.call(newList) !== '[object Array]') {
      return;
    }

    for (var i = 0; i < lastIdentifiers.length; i++) {
      var identifier = lastIdentifiers[i];
      var index = getIndexByIdentifier(identifier);
      stylesInDom[index].references--;
    }

    var newLastIdentifiers = modulesToDom(newList, options);

    for (var _i = 0; _i < lastIdentifiers.length; _i++) {
      var _identifier = lastIdentifiers[_i];

      var _index = getIndexByIdentifier(_identifier);

      if (stylesInDom[_index].references === 0) {
        stylesInDom[_index].updater();

        stylesInDom.splice(_index, 1);
      }
    }

    lastIdentifiers = newLastIdentifiers;
  };
};

/***/ })

/******/ });
//# sourceMappingURL=application-aa87704ad08d400e9038.js.map