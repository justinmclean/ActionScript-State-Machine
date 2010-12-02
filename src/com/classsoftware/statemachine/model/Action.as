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
	 * An action in a state machine.
	 * @author justinmclean
	 */
	public class Action
	{
		
		/**
		 * Creates a new action. The action method is optional.
		 * @param fromState State to move form.
		 * @param toState State to move to.
		 * @param name Action's name.
		 * @param action Method to call on performing action.
		 */
		public function Action(fromState:State, toState:State, name:String, action:Function = null)
		{
			_fromState = fromState;
			_toState = toState;
			_name = name;
			_action = action;
		}

		private var _action:Function;
		private var _fromState:State;
		private var _name:String;
		private var _toState:State;

		/**
		 * @return The methood to call on preforming the action.
		 */
		public function get action():Function
		{
			return _action;
		}

		/**
		 * @return The state to move from.
		 */
		public function get fromState():State
		{
			return _fromState;
		}

		/**
		 * @return The action's name.
		 */
		public function get name():String
		{
			return _name;
		}

		/**
		 * @return  The state to move to.
		 */
		public function get toState():State
		{
			return _toState;
		}
	}
}