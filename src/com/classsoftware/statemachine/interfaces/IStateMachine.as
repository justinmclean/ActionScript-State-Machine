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

package com.classsoftware.statemachine.interfaces {
	import com.classsoftware.statemachine.model.State;
	/**
	 * interface for a state machine.
	 * @author justinmclean
	 * @see Events
	 */
	public interface IStateMachine {

		function actionExists(checkAction:String):Boolean;
		
		function addAction(fromState:String, toState:String, action:String, handler:Function = null):Boolean;

		function addState(newState:String):Boolean;

		function changeState(toState:String):Boolean;

		function currentState():String;

		function performAction(actionName:String):Boolean;

		function reset():void;

		function stateExists(checkState:String):Boolean;

		function validActions():Array;

		function validStates():Array;
	}
}