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

package com.classsoftware.statemachine {
	import com.classsoftware.history.History;
	import com.classsoftware.history.IHistory;
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	import com.classsoftware.statemachine.model.Action;
	import com.classsoftware.statemachine.model.State;
	
	/**
	 * Adds the ability for a state machine (of any type) to remember and move about it's own history of state changes.
	 * @author justinmclean
	 * @see StateMachine
	 */
	public class HistoryStateMachine implements IStateMachine, IHistory {

		/**
		 * Create a history state machine.
		 * @param stateMachine State machine to add history ability to.
		 */
		public function HistoryStateMachine(stateMachine:IStateMachine) {
			_stateMachine = stateMachine;
			_history = new com.classsoftware.history.History();
		}
		
		/**
		 * Remembers history of state machine.
		 * @default 
		 */
		protected var _history:com.classsoftware.history.History = null;
		
		/**
		 * The original state machine.
		 * @default 
		 */
		protected var _stateMachine:IStateMachine;

		/**
		 * Does an action exist?
		 * @see StateMachine#actionExists
		 */
		public function actionExists(checkAction:String):Boolean {
			return _stateMachine.actionExists(checkAction);
		}

		/**
		 * Add an action and saves history if first state added.
		 * @see StateMachine#addAction
		 */
		public function addAction(fromState:String, toState:String, action:String, handler:Function = null):Boolean {
			saveStateIfFirst(fromState);
			return _stateMachine.addAction(fromState, toState, action, handler);
		}

		/**
		 * Add a new state and saves history if first state added.
		 * @see StateMachine#addState 
		 */
		public function addState(newState:String):Boolean {
			saveStateIfFirst(newState);	
			return _stateMachine.addState(newState);
		}

		/**
		 * Change state and save history.
		 * @see StateMachine#changeState 
		 */
		public function changeState(toState:String):Boolean {
			for each (var action:Action in validActions()) {
				if (action.toState.name == toState) {
					_history.save(toState);
					break;
				}
			}

			return _stateMachine.changeState(toState);
		}

		/**
		 * Current state.
		 * @see StateMachine#currentState  
		 */
		public function currentState():String {
			return _stateMachine.currentState();
		}

		/**
		 * Go to the next state in the history.
		 * @return True if the state machine was able to go to the next state, false if it was not.
		 */
		public function next():Boolean {
			_stateMachine.changeState(_history.getNext());
			return _history.next();
		}

		/**
		 * Perform action and save state.
		 * @see StateMachine#performAction 
		 */
		public function performAction(actionName:String):Boolean {
			for each (var action:Action in validActions()) {
				if (action.name == actionName) {
					_history.save(action.toState.name);
					break;
				}
			}

			return _stateMachine.performAction(actionName);
		}

		/**
		 * Goto perevious state in history.
		 * @return True if able to go to previous state, false if state machine cannot go to to previous state.
		 */
		public function previous():Boolean {
			_stateMachine.changeState(_history.getPrevious());
			return _history.previous();
		}

		/**
		 * Resets the state machine.
		 * @see StateMachine#reset 
		 */
		public function reset():void {
			_history.reset();
			_stateMachine.reset();
		}

		/**
		 * Does a state exist?
		 * @see StateMachine#stateExists 
		 */
		public function stateExists(checkState:String):Boolean {
			return _stateMachine.stateExists(checkState);
		}

		/**
		 * List of valid actions from current state.
		 * @see StateMachine#validActions 
		 */
		public function validActions():Array {
			return _stateMachine.validActions();
		}

		/**
		 * List of valid states from current state.
		 * @see StateMachine#validStates  
		 */
		public function validStates():Array {
			return _stateMachine.validStates();
		}
				
		private function saveStateIfFirst(fromState:String):void
		{
			// Save state in history if it's the first
			if (currentState() == null) {
				_history.save(fromState);
			}
		}	
	}
}