
// usage: log('inside coolFunc', this, arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function(){
  log.history = log.history || [];   // store logs to an array for reference
  log.history.push(arguments);
  if(this.console) {
    arguments.callee = arguments.callee.caller;
    var newarr = [].slice.call(arguments);
    (typeof console.log === 'object' ? log.apply.call(console.log, console, newarr) : console.log.apply(console, newarr));
  }
};

// make it safe to use console.log always
(function(b){function c(){}for(var d="assert,clear,count,debug,dir,dirxml,error,exception,firebug,group,groupCollapsed,groupEnd,info,log,memoryProfile,memoryProfileEnd,profile,profileEnd,table,time,timeEnd,timeStamp,trace,warn".split(","),a;a=d.pop();){b[a]=b[a]||c}})((function(){try
{console.log();return window.console;}catch(err){return window.console={};}})());


// place any jQuery/helper plugins in here, instead of separate, slower script files.



/* =========================================================
 * bootstrap-modal.js v2.0.1
 * http://twitter.github.com/bootstrap/javascript.html#modals
 * =========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */


!function( $ ){

  "use strict"

 /* MODAL CLASS DEFINITION
  * ====================== */

  var Modal = function ( content, options ) {
    this.options = options
    this.$element = $(content)
      .delegate('[data-dismiss="modal"]', 'click.dismiss.modal', $.proxy(this.hide, this))
  }

  Modal.prototype = {

      constructor: Modal

    , toggle: function () {
        return this[!this.isShown ? 'show' : 'hide']()
      }

    , show: function () {
        var that = this

        if (this.isShown) return

        $('body').addClass('modal-open')

        this.isShown = true
        this.$element.trigger('show')

        escape.call(this)
        backdrop.call(this, function () {
          var transition = $.support.transition && that.$element.hasClass('fade')

          !that.$element.parent().length && that.$element.appendTo(document.body) //don't move modals dom position

          that.$element
            .show()

          if (transition) {
            that.$element[0].offsetWidth // force reflow
          }

          that.$element.addClass('in')

          transition ?
            that.$element.one($.support.transition.end, function () { that.$element.trigger('shown') }) :
            that.$element.trigger('shown')

        })
      }

    , hide: function ( e ) {
        e && e.preventDefault()

        if (!this.isShown) return

        var that = this
        this.isShown = false

        $('body').removeClass('modal-open')

        escape.call(this)

        this.$element
          .trigger('hide')
          .removeClass('in')

        $.support.transition && this.$element.hasClass('fade') ?
          hideWithTransition.call(this) :
          hideModal.call(this)
      }

  }


 /* MODAL PRIVATE METHODS
  * ===================== */

  function hideWithTransition() {
    var that = this
      , timeout = setTimeout(function () {
          that.$element.off($.support.transition.end)
          hideModal.call(that)
        }, 500)

    this.$element.one($.support.transition.end, function () {
      clearTimeout(timeout)
      hideModal.call(that)
    })
  }

  function hideModal( that ) {
    this.$element
      .hide()
      .trigger('hidden')

    backdrop.call(this)
  }

  function backdrop( callback ) {
    var that = this
      , animate = this.$element.hasClass('fade') ? 'fade' : ''

    if (this.isShown && this.options.backdrop) {
      var doAnimate = $.support.transition && animate

      this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />')
        .appendTo(document.body)

      if (this.options.backdrop != 'static') {
        this.$backdrop.click($.proxy(this.hide, this))
      }

      if (doAnimate) this.$backdrop[0].offsetWidth // force reflow

      this.$backdrop.addClass('in')

      doAnimate ?
        this.$backdrop.one($.support.transition.end, callback) :
        callback()

    } else if (!this.isShown && this.$backdrop) {
      this.$backdrop.removeClass('in')

      $.support.transition && this.$element.hasClass('fade')?
        this.$backdrop.one($.support.transition.end, $.proxy(removeBackdrop, this)) :
        removeBackdrop.call(this)

    } else if (callback) {
      callback()
    }
  }

  function removeBackdrop() {
    this.$backdrop.remove()
    this.$backdrop = null
  }

  function escape() {
    var that = this
    if (this.isShown && this.options.keyboard) {
      $(document).on('keyup.dismiss.modal', function ( e ) {
        e.which == 27 && that.hide()
      })
    } else if (!this.isShown) {
      $(document).off('keyup.dismiss.modal')
    }
  }


 /* MODAL PLUGIN DEFINITION
  * ======================= */

  $.fn.modal = function ( option ) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('modal')
        , options = $.extend({}, $.fn.modal.defaults, $this.data(), typeof option == 'object' && option)
      if (!data) $this.data('modal', (data = new Modal(this, options)))
      if (typeof option == 'string') data[option]()
      else if (options.show) data.show()
    })
  }

  $.fn.modal.defaults = {
      backdrop: true
    , keyboard: true
    , show: true
  }

  $.fn.modal.Constructor = Modal


 /* MODAL DATA-API
  * ============== */

  $(function () {
    $('body').on('click.modal.data-api', '[data-toggle="modal"]', function ( e ) {
      var $this = $(this), href
        , $target = $($this.attr('data-target') || (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, '')) //strip for ie7
        , option = $target.data('modal') ? 'toggle' : $.extend({}, $target.data(), $this.data())

      e.preventDefault()
      $target.modal(option)
    })
  })

}( window.jQuery );



/*
* jQuery.eraser v0.2
* makes any image or canvas erasable by the user, using touch or mouse input
*
* Usage:
*
* $('#myImage').eraser(); // simple way
*
* $(#canvas').eraser( { 
*   size: 20, // define brush size (default value is 40)
*   completeRatio: .65, // allows to call function when a erased ratio is reached (between 0 and 1, default is .7 )
*   completeFunction: myFunction // callback function when complete ratio is reached
* } ); 
*
* $('#image').eraser( 'clear' ); // removes canvas content
*
* $('#image').eraser( 'reset' ); // revert back to original content
*
*
* https://github.com/boblemarin/jQuery.eraser
* http://minimal.be/lab/jQuery.eraser/
*
* Copyright (c) 2010 boblemarin emeric@minimal.be http://www.minimal.be
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

(function( $ ){
	var methods = {
		init : function( options ) {
			return this.each(function(){
				var $this = $(this),
					data = $this.data('eraser');

				if ( !data ) {
					var width = $this.width(),
						height = $this.height(),
						pos = $this.offset(),
						$canvas = $("<canvas/>"),
						canvas = $canvas.get(0),
						size = ( options && options.size )?options.size:40,
						completeRatio = ( options && options.completeRatio )?options.completeRatio:.7,
						completeFunction = ( options && options.completeFunction )?options.completeFunction:null,
						parts = [],
						colParts = Math.floor( width / size ),
						numParts = colParts * Math.floor( height / size ),
						n = numParts,
						ctx = canvas.getContext("2d");

					// replace target with canvas
					$this.after( $canvas );
					canvas.id = this.id;
					canvas.className = this.className;
					canvas.width = width;
					canvas.height = height;
					ctx.drawImage( this, 0, 0 );
					$this.remove();

					// prepare context for drawing operations
					ctx.globalCompositeOperation = "destination-out";
					ctx.strokeStyle = 'rgba(255,0,0,255)';
					ctx.lineWidth = size;

					ctx.lineCap = "round";
					// bind events
					$canvas.bind('mousedown.eraser', methods.mouseDown);
					$canvas.bind('touchstart.eraser', methods.touchStart);
					$canvas.bind('touchmove.eraser', methods.touchMove);
					$canvas.bind('touchend.eraser', methods.touchEnd);

					// reset parts
					while( n-- ) parts.push(1);

					// store values
					data = {
						posX:pos.left,
						posY:pos.top,
						touchDown: false,
						touchID:-999,
						touchX: 0,
						touchY: 0,
						ptouchX: 0,
						ptouchY: 0,
						canvas: $canvas,
						ctx: ctx,
						w:width,
						h:height,
						source: this,
						size: size,
						parts: parts,
						colParts: colParts,
						numParts: numParts,
						ratio: 0,
						complete: false,
						completeRatio: completeRatio,
						completeFunction: completeFunction
					};
					$canvas.data('eraser', data);

					// listen for resize event to update offset values	
					$(window).resize( function() {
						var pos = $canvas.offset();
						data.posX = pos.left;
						data.posY = pos.top;
					});
				}
			});
		},
		touchStart: function( event ) {
			var $this = $(this),
				data = $this.data('eraser');

			if ( !data.touchDown ) {
				var t = event.originalEvent.changedTouches[0],
					tx = t.pageX - data.posX,
					ty = t.pageY - data.posY;
				methods.evaluatePoint( data, tx, ty );
				data.touchDown = true;
				data.touchID = t.identifier;
				data.touchX = tx;
				data.touchY = ty;
				event.preventDefault();
			}
		},
		touchMove: function( event ) {
			var $this = $(this),
				data = $this.data('eraser');

			if ( data.touchDown ) {
				var ta = event.originalEvent.changedTouches,
					n = ta.length;
				while( n-- ) 
					if ( ta[n].identifier == data.touchID ) {
						var tx = ta[n].pageX - data.posX,
							ty = ta[n].pageY - data.posY;
						methods.evaluatePoint( data, tx, ty );
						data.ctx.beginPath();
						data.ctx.moveTo( data.touchX, data.touchY );
						data.touchX = tx;
						data.touchY = ty;
						data.ctx.lineTo( data.touchX, data.touchY );
						data.ctx.stroke();
						event.preventDefault();
						break;
					}
			}
		},
		touchEnd: function( event ) {
			var $this = $(this),
				data = $this.data('eraser');

			if ( data.touchDown ) {
				var ta = event.originalEvent.changedTouches,
					n = ta.length;
				while( n-- )
					if ( ta[n].identifier == data.touchID ) {
						data.touchDown = false;
						event.preventDefault();
						break;
					}
			}
		},

		evaluatePoint: function( data, tx, ty ) {
			var p = Math.floor(tx/data.size) + Math.floor( ty / data.size ) * data.colParts;
			if ( p >= 0 && p < data.numParts ) {
				data.ratio += data.parts[p];
				data.parts[p] = 0;
				if ( !data.complete) {
					if ( data.ratio/data.numParts >= data.completeRatio ) {
						data.complete = true;
						if ( data.completeFunction != null ) data.completeFunction();
					}
				}
			}

		},

		mouseDown: function( event ) {
			var $this = $(this),
				data = $this.data('eraser'),
				tx = event.pageX - data.posX,
				ty = event.pageY - data.posY;
			methods.evaluatePoint( data, tx, ty );				
			data.touchDown = true;
			data.touchX = tx;
			data.touchY = ty;
			data.ctx.beginPath();
			data.ctx.moveTo( data.touchX-1, data.touchY );
			data.ctx.lineTo( data.touchX, data.touchY );
			data.ctx.stroke();
			$this.bind('mousemove.eraser', methods.mouseMove);
			$this.bind('mouseup.eraser', methods.mouseUp);
			event.preventDefault();
		},

		mouseMove: function( event ) {
			var $this = $(this),
				data = $this.data('eraser'),
				tx = event.pageX - data.posX,
				ty = event.pageY - data.posY;
			methods.evaluatePoint( data, tx, ty );
			data.ctx.beginPath();
			data.ctx.moveTo( data.touchX, data.touchY );
			data.touchX = tx;
			data.touchY = ty;
			data.ctx.lineTo( data.touchX, data.touchY );
			data.ctx.stroke();
			event.preventDefault();
		},

		mouseUp: function( event ) {
			var $this = $(this),
				data = $this.data('eraser');

			data.touchDown = false;
			$this.unbind('mousemove.eraser');
			$this.unbind('mouseup.eraser');
			event.preventDefault();
		},

		clear: function() {
			var $this = $(this),
				data = $this.data('eraser');
			if ( data )
			{
				data.ctx.clearRect( 0, 0, data.w, data.h );
				var n = data.numParts;
				while( n-- ) data.parts[n] = 0;
				data.ratio = data.numParts;
				data.complete = true;
				if ( data.completeFunction != null ) data.completeFunction();
			}
		},

		reset: function() {
			var $this = $(this),
				data = $this.data('eraser');
			if ( data )
			{
				data.ctx.globalCompositeOperation = "source-over";
				data.ctx.drawImage( data.source, 0, 0 );
				data.ctx.globalCompositeOperation = "destination-out";
				var n = data.numParts;
				while( n-- ) data.parts[n] = 1;
				data.ratio = 0;
				data.complete = false;
			}

		}
	};

	$.fn.eraser = function( method ) {
		if ( methods[method] ) {
			return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not yet exist on jQuery.eraser' );
		}
	};
})( jQuery );



// miniColors

/*
 * jQuery miniColors: A small color selector
 *
 * Copyright 2011 Cory LaViska for A Beautiful Site, LLC. (http://abeautifulsite.net/)
 *
 * Dual licensed under the MIT or GPL Version 2 licenses
 *
*/
if(jQuery)(function($){$.extend($.fn,{miniColors:function(o,data){var create=function(input,o,data){var color=expandHex(input.val());if(!color)color='ffffff';var hsb=hex2hsb(color);var trigger=$('<a class="miniColors-trigger" style="background-color: #'+color+'" href="#"></a>');trigger.insertAfter(input);input.addClass('miniColors').data('original-maxlength',input.attr('maxlength')||null).data('original-autocomplete',input.attr('autocomplete')||null).data('letterCase','uppercase').data('trigger',trigger).data('hsb',hsb).data('change',o.change?o.change:null).attr('maxlength',7).attr('autocomplete','off').val('#'+convertCase(color,o.letterCase));if(o.readonly)input.prop('readonly',true);if(o.disabled)disable(input);trigger.bind('click.miniColors',function(event){event.preventDefault();if(input.val()==='')input.val('#');show(input)});input.bind('focus.miniColors',function(event){if(input.val()==='')input.val('#');show(input)});input.bind('blur.miniColors',function(event){var hex=expandHex(input.val());input.val(hex?'#'+convertCase(hex,input.data('letterCase')):'')});input.bind('keydown.miniColors',function(event){if(event.keyCode===9)hide(input)});input.bind('keyup.miniColors',function(event){setColorFromInput(input)});input.bind('paste.miniColors',function(event){setTimeout(function(){setColorFromInput(input)},5)})};var destroy=function(input){hide();input=$(input);input.data('trigger').remove();input.attr('autocomplete',input.data('original-autocomplete')).attr('maxlength',input.data('original-maxlength')).removeData().removeClass('miniColors').unbind('.miniColors');$(document).unbind('.miniColors')};var enable=function(input){input.prop('disabled',false).data('trigger').css('opacity',1)};var disable=function(input){hide(input);input.prop('disabled',true).data('trigger').css('opacity',0.5)};var show=function(input){if(input.prop('disabled'))return false;hide();var selector=$('<div class="miniColors-selector"></div>');selector.append('<div class="miniColors-colors" style="background-color: #FFF;"><div class="miniColors-colorPicker"></div></div>').append('<div class="miniColors-hues"><div class="miniColors-huePicker"></div></div>').css({top:input.is(':visible')?input.offset().top+input.outerHeight():input.data('trigger').offset().top+input.data('trigger').outerHeight(),left:input.is(':visible')?input.offset().left:input.data('trigger').offset().left,display:'none'}).addClass(input.attr('class'));var hsb=input.data('hsb');selector.find('.miniColors-colors').css('backgroundColor','#'+hsb2hex({h:hsb.h,s:100,b:100}));var colorPosition=input.data('colorPosition');if(!colorPosition)colorPosition=getColorPositionFromHSB(hsb);selector.find('.miniColors-colorPicker').css('top',colorPosition.y+'px').css('left',colorPosition.x+'px');var huePosition=input.data('huePosition');if(!huePosition)huePosition=getHuePositionFromHSB(hsb);selector.find('.miniColors-huePicker').css('top',huePosition.y+'px');input.data('selector',selector).data('huePicker',selector.find('.miniColors-huePicker')).data('colorPicker',selector.find('.miniColors-colorPicker')).data('mousebutton',0);$('BODY').append(selector);selector.fadeIn(100);selector.bind('selectstart',function(){return false});$(document).bind('mousedown.miniColors touchstart.miniColors',function(event){input.data('mousebutton',1);if($(event.target).parents().andSelf().hasClass('miniColors-colors')){event.preventDefault();input.data('moving','colors');moveColor(input,event)}if($(event.target).parents().andSelf().hasClass('miniColors-hues')){event.preventDefault();input.data('moving','hues');moveHue(input,event)}if($(event.target).parents().andSelf().hasClass('miniColors-selector')){event.preventDefault();return}if($(event.target).parents().andSelf().hasClass('miniColors'))return;hide(input)});$(document).bind('mouseup.miniColors touchend.miniColors',function(event){event.preventDefault();input.data('mousebutton',0).removeData('moving')}).bind('mousemove.miniColors touchmove.miniColors',function(event){event.preventDefault();if(input.data('mousebutton')===1){if(input.data('moving')==='colors')moveColor(input,event);if(input.data('moving')==='hues')moveHue(input,event)}})};var hide=function(input){if(!input)input='.miniColors';$(input).each(function(){var selector=$(this).data('selector');$(this).removeData('selector');$(selector).fadeOut(100,function(){$(this).remove()})});$(document).unbind('.miniColors')};var moveColor=function(input,event){var colorPicker=input.data('colorPicker');colorPicker.hide();var position={x:event.pageX,y:event.pageY};if(event.originalEvent.changedTouches){position.x=event.originalEvent.changedTouches[0].pageX;position.y=event.originalEvent.changedTouches[0].pageY}position.x=position.x-input.data('selector').find('.miniColors-colors').offset().left-5;position.y=position.y-input.data('selector').find('.miniColors-colors').offset().top-5;if(position.x<=-5)position.x=-5;if(position.x>=144)position.x=144;if(position.y<=-5)position.y=-5;if(position.y>=144)position.y=144;input.data('colorPosition',position);colorPicker.css('left',position.x).css('top',position.y).show();var s=Math.round((position.x+5)*0.67);if(s<0)s=0;if(s>100)s=100;var b=100-Math.round((position.y+5)*0.67);if(b<0)b=0;if(b>100)b=100;var hsb=input.data('hsb');hsb.s=s;hsb.b=b;setColor(input,hsb,true)};var moveHue=function(input,event){var huePicker=input.data('huePicker');huePicker.hide();var position={y:event.pageY};if(event.originalEvent.changedTouches){position.y=event.originalEvent.changedTouches[0].pageY}position.y=position.y-input.data('selector').find('.miniColors-colors').offset().top-1;if(position.y<=-1)position.y=-1;if(position.y>=149)position.y=149;input.data('huePosition',position);huePicker.css('top',position.y).show();var h=Math.round((150-position.y-1)*2.4);if(h<0)h=0;if(h>360)h=360;var hsb=input.data('hsb');hsb.h=h;setColor(input,hsb,true)};var setColor=function(input,hsb,updateInput){input.data('hsb',hsb);var hex=hsb2hex(hsb);if(updateInput)input.val('#'+convertCase(hex,input.data('letterCase')));input.data('trigger').css('backgroundColor','#'+hex);if(input.data('selector'))input.data('selector').find('.miniColors-colors').css('backgroundColor','#'+hsb2hex({h:hsb.h,s:100,b:100}));if(input.data('change')){if(hex===input.data('lastChange'))return;input.data('change').call(input.get(0),'#'+hex,hsb2rgb(hsb));input.data('lastChange',hex)}};var setColorFromInput=function(input){input.val('#'+cleanHex(input.val()));var hex=expandHex(input.val());if(!hex)return false;var hsb=hex2hsb(hex);var currentHSB=input.data('hsb');if(hsb.h===currentHSB.h&&hsb.s===currentHSB.s&&hsb.b===currentHSB.b)return true;var colorPosition=getColorPositionFromHSB(hsb);var colorPicker=$(input.data('colorPicker'));colorPicker.css('top',colorPosition.y+'px').css('left',colorPosition.x+'px');input.data('colorPosition',colorPosition);var huePosition=getHuePositionFromHSB(hsb);var huePicker=$(input.data('huePicker'));huePicker.css('top',huePosition.y+'px');input.data('huePosition',huePosition);setColor(input,hsb);return true};var convertCase=function(string,letterCase){if(letterCase==='lowercase')return string.toLowerCase();if(letterCase==='uppercase')return string.toUpperCase();return string};var getColorPositionFromHSB=function(hsb){var x=Math.ceil(hsb.s/0.67);if(x<0)x=0;if(x>150)x=150;var y=150-Math.ceil(hsb.b/0.67);if(y<0)y=0;if(y>150)y=150;return{x:x-5,y:y-5}};var getHuePositionFromHSB=function(hsb){var y=150-(hsb.h/2.4);if(y<0)h=0;if(y>150)h=150;return{y:y-1}};var cleanHex=function(hex){return hex.replace(/[^A-F0-9]/ig,'')};var expandHex=function(hex){hex=cleanHex(hex);if(!hex)return null;if(hex.length===3)hex=hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2];return hex.length===6?hex:null};var hsb2rgb=function(hsb){var rgb={};var h=Math.round(hsb.h);var s=Math.round(hsb.s*255/100);var v=Math.round(hsb.b*255/100);if(s===0){rgb.r=rgb.g=rgb.b=v}else{var t1=v;var t2=(255-s)*v/255;var t3=(t1-t2)*(h%60)/60;if(h===360)h=0;if(h<60){rgb.r=t1;rgb.b=t2;rgb.g=t2+t3}else if(h<120){rgb.g=t1;rgb.b=t2;rgb.r=t1-t3}else if(h<180){rgb.g=t1;rgb.r=t2;rgb.b=t2+t3}else if(h<240){rgb.b=t1;rgb.r=t2;rgb.g=t1-t3}else if(h<300){rgb.b=t1;rgb.g=t2;rgb.r=t2+t3}else if(h<360){rgb.r=t1;rgb.g=t2;rgb.b=t1-t3}else{rgb.r=0;rgb.g=0;rgb.b=0}}return{r:Math.round(rgb.r),g:Math.round(rgb.g),b:Math.round(rgb.b)}};var rgb2hex=function(rgb){var hex=[rgb.r.toString(16),rgb.g.toString(16),rgb.b.toString(16)];$.each(hex,function(nr,val){if(val.length===1)hex[nr]='0'+val});return hex.join('')};var hex2rgb=function(hex){hex=parseInt(((hex.indexOf('#')>-1)?hex.substring(1):hex),16);return{r:hex>>16,g:(hex&0x00FF00)>>8,b:(hex&0x0000FF)}};var rgb2hsb=function(rgb){var hsb={h:0,s:0,b:0};var min=Math.min(rgb.r,rgb.g,rgb.b);var max=Math.max(rgb.r,rgb.g,rgb.b);var delta=max-min;hsb.b=max;hsb.s=max!==0?255*delta/max:0;if(hsb.s!==0){if(rgb.r===max){hsb.h=(rgb.g-rgb.b)/delta}else if(rgb.g===max){hsb.h=2+(rgb.b-rgb.r)/delta}else{hsb.h=4+(rgb.r-rgb.g)/delta}}else{hsb.h=-1}hsb.h*=60;if(hsb.h<0){hsb.h+=360}hsb.s*=100/255;hsb.b*=100/255;return hsb};var hex2hsb=function(hex){var hsb=rgb2hsb(hex2rgb(hex));if(hsb.s===0)hsb.h=360;return hsb};var hsb2hex=function(hsb){return rgb2hex(hsb2rgb(hsb))};switch(o){case'readonly':$(this).each(function(){if(!$(this).hasClass('miniColors'))return;$(this).prop('readonly',data)});return $(this);case'disabled':$(this).each(function(){if(!$(this).hasClass('miniColors'))return;if(data){disable($(this))}else{enable($(this))}});return $(this);case'value':if(data===undefined){if(!$(this).hasClass('miniColors'))return;var input=$(this),hex=expandHex(input.val());return hex?'#'+convertCase(hex,input.data('letterCase')):null}$(this).each(function(){if(!$(this).hasClass('miniColors'))return;$(this).val(data);setColorFromInput($(this))});return $(this);case'destroy':$(this).each(function(){if(!$(this).hasClass('miniColors'))return;destroy($(this))});return $(this);default:if(!o)o={};$(this).each(function(){if($(this)[0].tagName.toLowerCase()!=='input')return;if($(this).data('trigger'))return;create($(this),o,data)});return $(this)}}})})(jQuery);