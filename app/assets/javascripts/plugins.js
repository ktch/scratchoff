
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
