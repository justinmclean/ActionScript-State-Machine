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
	 * Events dispatched when a state machine changes state.
	 * @author justinmclean
	 */
	public class StateChangeEvent extends Event {
		/**
		 * A change between two states has occurred.
		 */
		public static const CHANGE_STATE:String = "ChangeState";
		
		/**
		 * StateChangeEvent constructor.
		 * @param type The type of event. Always CHANGE_STATE.
		 * @param fromState The state changing from. 
		 * @param toState The statge changed to.
		 * @param bubbles Does the event bubble?
		 * @param cancelable Can the event be canceled?
		 */
		public function StateChangeEvent(type:String, fromState:String, toState:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_fromState = fromState;
			_toState = toState;		
		}
		
		private var _toState:String;
		private var _fromState:String;

		/**
		 * @return The state changed to.
		 */
		public function get toState():String
		{
			return _toState;
		}
		
		/**
		 * @return The state changing from.
		 */
		public function get fromState():String
		{
			return _fromState;
		}		

		/**
		 * Create a copy of a StateChangeEvent. Used in event bubbling.
		 * @return A copy of the state change event.
		 */
		override public function clone():Event {
			return new StateChangeEvent(type, fromState, toState, bubbles, cancelable);
		}
	}
}

