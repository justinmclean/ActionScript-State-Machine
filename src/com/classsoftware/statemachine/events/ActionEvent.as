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

package com.classsoftware.statemachine.events {
	import flash.events.Event;
	
	/**
	 * Events dispatched when actions are performed on a state machine.
	 * @author justinmclean
	 */
	public class ActionEvent extends Event {
		/**
		 * An action has been performed.
		 */
		public static const PERFORM_ACTION:String = "PerformAction";
		
		/**
		 * StateChangeEvent constructor.
		 * @param type The type of event. Always PERFORM_ACTION.
		 * @param action The action performed. 
		 * @param bubbles Does the event bubble?
		 * @param cancelable Can the event be canceled?
		 */
		public function ActionEvent(type:String, action:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_action = action;
		}

		private var _action:String;

		/**
		 * @return The action performed.
		 */
		public function get action():String
		{
			return _action;
		}
		
		/**
		 * Create a copy of a ActionEvent. Used in event bubbling.
		 * @return A copy of the action event.
		 */
		override public  function clone():Event {
			return new ActionEvent(type, action, bubbles, cancelable);
		}
	}
}

