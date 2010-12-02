//------------------------------------------------------------------------------
//
//Copyright (c) 2010 Justin Mclean Class Software (justin@classsoftware.com) 
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal 
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions: 
// 
// The above copyright notice and this permission notice shall be included in 
// all copies or substantial portions of the Software. 
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
// THE SOFTWARE. 
//
//------------------------------------------------------------------------------

package com.classsoftware.history {
	/**
	 * Keeps a record of a history and enables you to go forwards and backwards through that history.
	 * History stored can be of any type or object.
	 * @author justinmclean
	 */
	public class History implements IHistory {
		/**
		 * History constructor. Does nothing special.
		 */
		public function History() {
		}

		private var _history:Array = [];
		private var _historyIndex:int = 0;
		
		/**
		 * Get current item in the history.
		 * @return The current item.
		 */
		public function getCurrent():* {
			return _history[_historyIndex];
		}		
		
		/**
		 * The next item in the history.
		 * @return The next item.
		 */
		public function getNext():* {
			if (!isNext()) {
				return null;
			}
			return _history[_historyIndex+1];
		}
		
		/**
		 * The previous item in the history.
		 * @return The previous item.
		 */
		public function getPrevious():* {
			if (!isPrevious()) {
				return null;
			}
			return _history[_historyIndex-1];
		}

		/**
		 * Is there a next item in the history.
		 * @return true if there is a next item.
		 */
		public function isNext():Boolean {
			return _historyIndex < _history.length - 1;
		}

		/**
		 * Is there a previous item in the history.
		 * @return true if there is a previous item.
		 */
		public function isPrevious():Boolean {
			return _historyIndex > 0;
		}

		/**
		 * Move to next item in the history.
		 * @return true if there was an next item to go to.
		 */
		public function next():Boolean {
			if (!isNext()) {
				return false;
			}

			_historyIndex++;
			return true;
		}

		/**
		 * Move to the previous item in the hostory.
		 * @return 
		 */
		public function previous():Boolean {
			if (!isPrevious()) {
				return false;
			}

			_historyIndex--;
			return true;
		}

		/**
		 * Reset (remove) the history.
		 */
		public function reset():void {
			_history = [];
			_historyIndex = 0;
		}

		/**
		 * Save an item of any type into the history.
		 */
		public function save(item:*):void {
			if (_historyIndex != _history.length - 1) {
				_history.splice(_historyIndex + 1);
			}
			_history.push(item);
			_historyIndex = _history.length - 1;
		}
	}
}