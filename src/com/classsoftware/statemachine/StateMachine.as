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
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	import com.classsoftware.statemachine.model.Action;
	import com.classsoftware.statemachine.model.State;
	
	/**
	 * Creates a state machine whith the ability to add states and actions and move between states and perform actions.
	 * @author justinmclean
	 */
	public class StateMachine implements IStateMachine {

		/**
		 * Create a state machine and populate with states
		 */
		public function StateMachine() {
		}

		protected var _actions:Vector.<Action> = new Vector.<Action>();
		protected var _currentState:State = null;
		protected var _states:Vector.<State> = new Vector.<State>();
		
		/**
		 * Does an action exist in the state machine?
		 * @param action The action in question.
		 * @return True if the action exists, false if it does not.
		 */
		public function actionExists(checkAction:String):Boolean {
			return (findAction(checkAction) != null);
		}

		/**
		 * Add a valid link between two states.
		 * The state machine can then move between
		 * @param fromState State you want to move from.
		 * @param toState State you want to move to.
		 * @param action Action that when performed will move from the from state to the to state.
		 * @param handler Optional method that gets called when moving between these two states.
		 * @return true if link was added, false if it was not.
		 */ 
		public function addAction(fromState:String, toState:String, action:String, handler:Function = null):Boolean {
			var from:State;
			var to:State;
			
			// can't have duplicate actions
			for each (var check:Action in _actions) {
				if (check.fromState.name == fromState && check.name == action) {
					return false;
				}
			}
			
			from = findState(fromState);		
			if (from == null) {
				addState(fromState);
				from = findState(fromState);
			}

			to = findState(toState);		
			if (to == null) {
				addState(toState);
				to = findState(toState);
			}
			
			_actions.push(new Action(from, to, action, handler));

			return true;
		}


		/**
		 * Adds a new state to the state machine.
		 * @param newState The new state to add.
		 * @return Ture is teh state was added, false if it was not.
		 */
		public function addState(newState:String):Boolean {
			// can't have duplicate states
			if (stateExists(newState)) {
				return false;
			}
			
			_states.push(new State(newState));

			// if no states exist set current state to first state
			if (_states.length == 1) {
				_currentState = _states[0];
			}

			return true;
		}

		/**
		 * Move from the current state to another state.
		 * @param toState New state to try and move to.
		 * @return True if the state machine has moved to this new state, false if it was unable to do so.
		 */
		public function changeState(toState:String):Boolean {
			if (!stateExists(toState)) {
				return false;
			}
			
			for each (var action:Action in _actions) {
				if (action.fromState == _currentState && action.toState.name == toState) {	
					if (action.action != null) {
						action.action();
					}
					_currentState = action.toState;
					return true;
				}
			}

			return false;
		}

		/**
		 * What is the current state?
		 * @return The curent state.
		 */
		public function currentState():String {
			if (_currentState != null) {
				return _currentState.name;
			}
			else {
				return null;
			}
		}

		/**
		 * Change the current state by performing an action.
		 * @param action The action to perform.
		 * @return True if the action was able to be performed and the state machine moved to a new state, false if the action was unable to be performed.
		 */
		public function performAction(actionName:String):Boolean {
			for each (var action:Action in _actions) {
				if (action.fromState == _currentState && actionName == action.name) {
					if (action.action != null) {
						action.action();
					}
					_currentState = action.toState;
					return true;
				}
			}

			return false;
		}

		/**
		 * Go back to the initial starting state
		 */
		public function reset():void {
			if (_states.length > 0) {
				_currentState = _states[0];
			}
			else {
				_currentState = null;
			}
		}

		/**
		 * Does a state exist?
		 * @param state The state in question.
		 * @return True if the state exists, false if it does not.
		 */
		public function stateExists(checkState:String):Boolean {
			for each (var state:State in _states) {
				if (checkState == state.name) {
					return true;
				}
			}
			
			return false;
		}

		/**
		 * What are the valid actions you can perform from the current state?
		 * @return An array of actions.
		 */
		public function validActions():Array {
			var actions:Array = [];

			for each (var action:Action in _actions) {
				if (action.fromState == _currentState) {
					actions.push(action);
				}
			}

			return actions;
		}

		/**
		 * What are the valid states you can get to from the current state?
		 * @return An array of states.
		 */
		public function validStates():Array {
			var states:Array = [];

			for each (var action:Action in _actions) {
				if (action.fromState == _currentState) {
					states.push(action.toState);
				}
			}

			return states;
		}

		private function findState(exists:String):State
		{
			var found:State = null;
			
			for each (var state:State in _states) {
				if (state.name == exists) {
					found = state;
					break;
				}
			}
			
			return found;
		}
		
		private function findAction(exists:String):Action
		{
			var found:Action = null;
			
			for each (var action:Action in _actions) {
				if (action.name == exists) {
					found = action;
					break;
				}
			}
			
			return found;
		}
		
	}
}

