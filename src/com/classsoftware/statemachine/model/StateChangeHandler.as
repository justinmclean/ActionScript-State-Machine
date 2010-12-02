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

package com.classsoftware.statemachine.model
{
	/**
	 * Hander for a state change in a state machine.
	 * @author justinmclean
	 */
	public class StateChangeHandler
	{
		
		/**
		 * Creates a new state change handler.
		 * @param fromState State for move form.
		 * @param toState State to move to.
		 * @param handler Method to call on changing state.
		 */
		public function StateChangeHandler(fromState:String, toState:String, handler:Function)
		{
			_fromState = fromState;  
			_toState = toState;  
			_handler = handler;
		}

		private var _fromState:String;
		private var _handler:Function;
		private var _toState:String;

		/**
		 * @return State to move form.
		 */
		public function get fromState():String
		{
			return _fromState;
		}

		/** 
		 * @return Method to call on changing state.
		 */
		public function get handler():Function
		{
			return _handler;
		}

		/**
		 * @return  State to mobve to.
		 */
		public function get toState():String
		{
			return _toState;
		}
	}
}