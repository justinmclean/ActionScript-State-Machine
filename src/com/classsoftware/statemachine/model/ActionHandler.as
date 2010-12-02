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
	 * Handler for an action in a state machine.
	 * @author justinmclean
	 */
	public class ActionHandler
	{
		
		/**
		 * Create a new action handler.
		 * @param action The action's name.
		 * @param handler Method to call on performing an action.
		 */
		public function ActionHandler(action:String, handler:Function)
		{
			_action = action;  
			_handler = handler;
		}

		private var _action:String;
		private var _handler:Function;

		/**
		 * @return The action's name.
		 */
		public function get action():String
		{
			return _action;
		}

		/**
		 * @return Method to call on performing an action.
		 */
		public function get handler():Function
		{
			return _handler;
		}
	}
}