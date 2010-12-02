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
	import com.classsoftware.statemachine.events.ActionEvent;
	import com.classsoftware.statemachine.events.StateChangeEvent;
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	import com.classsoftware.statemachine.interfaces.IStateMachineEventListener;
	import com.classsoftware.statemachine.model.Action;
	import com.classsoftware.statemachine.model.ActionHandler;
	import com.classsoftware.statemachine.model.State;
	import com.classsoftware.statemachine.model.StateChangeHandler;
	import flash.events.EventDispatcher;
	
	/**
	 * Adds the ability for a state machine (of any type) to dispatch events on state changes.
	 * The state machine will listen for any event you ask it to (via addActionEventListener or addStateChangeEventListener) and call supplied handlers.
	 * You can also use the standard addEventListener to listen for ActionEvents or StateChangeEvents.	
	 * @author justinmclean
	 * @see StateMachine
	 * @see ActionEvent
	 * @see StateChangeEvent
	 */
	public class EventStateMachine extends EventDispatcher implements IStateMachine, IStateMachineEventListener {

		/**
		 * Create a event dispating state machine.
		 * @param stateMachine State machine to add event dispatching ability to.
		 */
		public function EventStateMachine(stateMachine:IStateMachine) {
			_stateMachine = stateMachine;
			
			addEventListener(ActionEvent.PERFORM_ACTION, onActionEvent, false, 0, true);
			addEventListener(StateChangeEvent.CHANGE_STATE, onStateChangeEvent, false, 0, true);
		}

		/**
		 * List of action handlers.
		 */
		protected var _actionHandlers:Vector.<ActionHandler> = new Vector.<ActionHandler>;
		
		/**
		 * List of state change handlers.
		 */
		protected var _stateChangeHandlers:Vector.<StateChangeHandler> = new Vector.<StateChangeHandler>;

		/**
		 * The original state machine.
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
		 * Adds an action.
		 * @see StateMachine#addAction
		 */
		public function addAction(fromState:String, toState:String, action:String, handler:Function = null):Boolean {
			return _stateMachine.addAction(fromState, toState, action, handler);
		}
		
		/**
		 * Adds a action event listener. An event will be dispatched when an action is performed.
		 * @param handler The method to call when the state machine changes state.
		 * @param action The action's name.
		 */
		public function addActionEventListener(handler:Function, action:String = null):void {
			_actionHandlers.push(new ActionHandler(action, handler));
		}

		/**
		 * Add a new state and saves history if first state added.
		 * @see StateMachine#addState 
		 */
		public function addState(newState:String):Boolean {
			return _stateMachine.addState(newState);
		}

		/**
		 * Adds a state change event listener. An event will be dispatched when the state machine changes state.
		 * @param handler The method to call when the state machine changes state.
		 * @param fromState The state to move form.
		 * @param toState The state to move to.
		 */
		public function addStateEventListener(handler:Function, fromState:String = null, toState:String = null):void {
			_stateChangeHandlers.push(new StateChangeHandler(fromState, toState, handler));
		}

		/**
		 * Change state.
		 * @see StateMachine#changeState 
		 */
		public function changeState(toState:String):Boolean {
			for each (var action:Action in validActions()) {
				if (action.toState.name == toState) {
					dispatchEvents(action.fromState, action.toState, action.name);
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
		 * Perform action and dispatch events.
		 * @see StateMachine#performAction 
		 */
		public function performAction(actionName:String):Boolean {
			for each (var action:Action in validActions()) {
				if (action.name == actionName) {
					dispatchEvents(action.fromState, action.toState, action.name);
					break;
				}
			}

			return _stateMachine.performAction(actionName);
		}
		
		/**
		 * Resets the state machine.
		 * @see StateMachine#reset 
		 */
		public function reset():void {
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

		/**
		 * Event handler for Action events.
		 * Calls all handlers that have been set up via calls to addActionEventListener.
		 * @param event Action event.
		 */
		protected function onActionEvent(event:ActionEvent):void {
			for each (var handler:ActionHandler in _actionHandlers) {
				if (handler.action == null || handler.action == event.action) {
					handler.handler();
				}
			}
		}

		protected function dispatchEvents(fromState:State, toState:State, action:String):void {
			// dispatch state change events
			dispatchEvent(new StateChangeEvent(StateChangeEvent.CHANGE_STATE, fromState.name, toState.name));
			// dispatch action events
			dispatchEvent(new ActionEvent(ActionEvent.PERFORM_ACTION, action));
		}

		/**
		 * Event handler for StateChange events.
		 * Calls all handlers that have been set up via calls to addStateEventListener.
		 * @param event StateChange event.
		 */
		protected function onStateChangeEvent(event:StateChangeEvent):void {
			for each (var handler:StateChangeHandler in _stateChangeHandlers) {
				// handlers for any state change
				if (handler.toState == null && handler.fromState == null) {
					handler.handler();
				}
				// handlers for a from state hander
				if (handler.toState == null && handler.fromState == event.fromState) {
					handler.handler();
				}
				// handlers for a to state hander
				if (handler.toState == event.toState && handler.fromState == null) {
					handler.handler();
				}
				// handlers for a to and from state hander
				if (handler.toState == event.toState && handler.fromState == event.fromState) {
					handler.handler();
				}				
			}
		}
	}
}