package flexUnitTests
{
	import com.classsoftware.statemachine.EventStateMachine;
	import com.classsoftware.statemachine.StateMachine;
	import com.classsoftware.statemachine.events.StateChangeEvent;
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	
	import flash.events.Event;
	
	import org.flexunit.Assert;

	public class EventStateMachineTest
	{	
		private var stateMachine:EventStateMachine;
		
		[Before]
		public function setUp():void
		{
			stateMachine = new EventStateMachine(new StateMachine());
		}
		
		private var calledSwitched:Boolean = false;
		private var calledLightsOn:Boolean = false;
		private var calledLightsOff:Boolean = false;
		
		private function switchedState():void {
			calledSwitched = true;
		}
		
		private function lightsOnState():void {
			calledLightsOn = true;
		}
		
		private function lightsOffState():void {
			calledLightsOff = true;
		}
		
		private function switchedAction():void {
			calledSwitched = true;
		}
		
		private function lightsOnAction():void {
			calledLightsOn = true;
		}
		
		private function lightsOffAction():void {
			calledLightsOff = true;
		}		
		
		[Test]
		public function stateChangeEvents():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off'));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));
			
			stateMachine.addStateEventListener(switchedState);
			stateMachine.addStateEventListener(lightsOnState, null, 'ON');
			stateMachine.addStateEventListener(lightsOffState, null, 'OFF');
	
			calledSwitched = false;
			calledLightsOn = false;
			calledLightsOff = false;
			
			Assert.assertTrue(stateMachine.changeState('OFF'));
			
			Assert.assertTrue(calledSwitched);
			Assert.assertFalse(calledLightsOn);
			Assert.assertTrue(calledLightsOff);
			
			calledSwitched = false;
			calledLightsOn = false;
			calledLightsOff = false;
			
			Assert.assertTrue(stateMachine.changeState('ON'));
			
			Assert.assertTrue(calledSwitched);
			Assert.assertTrue(calledLightsOn);
			Assert.assertFalse(calledLightsOff);
		}
		
		[Test]
		public function actionsEvents():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off'));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));
			
			stateMachine.addActionEventListener(switchedAction);
			stateMachine.addActionEventListener(lightsOnAction, 'Turn On');
			stateMachine.addActionEventListener(lightsOffAction, 'Turn Off');
			
			calledSwitched = false;
			calledLightsOn = false;
			calledLightsOff = false;
			
			Assert.assertTrue(stateMachine.changeState('OFF'));
			
			Assert.assertTrue(calledSwitched);
			Assert.assertFalse(calledLightsOn);
			Assert.assertTrue(calledLightsOff);
			
			calledSwitched = false;
			calledLightsOn = false;
			calledLightsOff = false;
			
			Assert.assertTrue(stateMachine.changeState('ON'));
			
			Assert.assertTrue(calledSwitched);
			Assert.assertTrue(calledLightsOn);
			Assert.assertFalse(calledLightsOff);
			
		}		
		
	}
}