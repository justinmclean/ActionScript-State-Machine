package flexUnitTests
{
	import com.classsoftware.statemachine.HistoryStateMachine;
	import com.classsoftware.statemachine.StateMachine;
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	import com.classsoftware.statemachine.model.State;
	
	import org.flexunit.Assert;

	public class StateMachineTest
	{	
		private var stateMachine:IStateMachine;
		
		[Before]
		public function setUp():void
		{
			stateMachine = new StateMachine();
		}
		
		[Test]
		public function addStates():void {	
			Assert.assertTrue(stateMachine.addState('ON'));
			Assert.assertTrue(stateMachine.addState('OFF'));
			Assert.assertFalse(stateMachine.addState('ON')); // try to add duplicate state
			
			Assert.assertEquals(stateMachine.currentState(), 'ON');
			
			Assert.assertTrue(stateMachine.stateExists('OFF'));
			Assert.assertTrue(stateMachine.stateExists('ON'));
			Assert.assertFalse(stateMachine.stateExists('Unknown'));
			
			var valid:Array = stateMachine.validStates();
			Assert.assertEquals(valid.length, 0);
			
			valid = stateMachine.validActions();
			Assert.assertEquals(valid.length, 0);		
		}
		
		[Test]
		public function addActions():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off', lightsOff));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));
			
			Assert.assertEquals(stateMachine.currentState(), 'ON');
			
			Assert.assertTrue(stateMachine.stateExists('ON'));
			Assert.assertTrue(stateMachine.stateExists('OFF'));
			Assert.assertFalse(stateMachine.stateExists('Unknown'));
			
			var valid:Array = stateMachine.validStates();
			Assert.assertEquals(valid.length, 1);
			Assert.assertEquals(valid[0].name, "OFF");
			valid = stateMachine.validActions();
			Assert.assertEquals(valid.length, 1);
			Assert.assertEquals(valid[0].name, "Turn Off");
			
			Assert.assertTrue(stateMachine.actionExists('Turn Off'));
			Assert.assertTrue(stateMachine.actionExists('Turn On'));
			Assert.assertFalse(stateMachine.actionExists('Unknown'));
		}
		
		[Test]
		public function changeStates():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off', lightsOff));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));
			
			Assert.assertEquals(stateMachine.currentState(), 'ON');
			Assert.assertTrue(stateMachine.changeState('OFF'));
			Assert.assertEquals(stateMachine.currentState(), 'OFF');
			Assert.assertFalse(stateMachine.changeState('OFF')); // can't change to this state	
			Assert.assertTrue(stateMachine.changeState('ON'));
			Assert.assertEquals(stateMachine.currentState(), 'ON');	
			Assert.assertFalse(stateMachine.changeState('ON')); // can't change to this state	
			
			Assert.assertFalse(stateMachine.changeState('Unknown'));
		}	
		
		private var lights:Boolean = true;
		
		private function lightsOff():void {
			lights = false;
		}
		
		[Test]
		public function performActions():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off', lightsOff));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));
			
			Assert.assertEquals(stateMachine.currentState(), 'ON');
			Assert.assertTrue(stateMachine.performAction('Turn Off'));
			Assert.assertFalse(lights); // check that lightsOff has been called
			Assert.assertEquals(stateMachine.currentState(), 'OFF');
			Assert.assertFalse(stateMachine.performAction('Turn Off'));	// Can't do this
			Assert.assertTrue(stateMachine.performAction('Turn On'));
			Assert.assertEquals(stateMachine.currentState(), 'ON');	
			Assert.assertFalse(stateMachine.performAction('Turn On')); // Can't do this
			
			Assert.assertFalse(stateMachine.performAction('Unknown'));
		}
		
		[Test]
		public function reset():void {
			Assert.assertTrue(stateMachine.addAction('ON', 'OFF', 'Turn Off', lightsOff));
			Assert.assertTrue(stateMachine.addAction('OFF', 'ON', 'Turn On'));

			Assert.assertEquals(stateMachine.currentState(), 'ON');
			Assert.assertTrue(stateMachine.performAction('Turn Off'));
			Assert.assertEquals(stateMachine.currentState(), 'OFF');
			
			stateMachine.reset();
			
			Assert.assertEquals(stateMachine.currentState(), 'ON');
		}
		
		[Test]
		public function makeCoffee():void {				
			Assert.assertTrue(stateMachine.addAction('EMPTY', 'WATER', 'Add Cold Water'));
			Assert.assertTrue(stateMachine.addAction('WATER', 'COFFEE', 'Add Coffee'));
			Assert.assertTrue(stateMachine.addAction('COFFEE', 'ONSTOVE', 'Put On Stove'));
			Assert.assertTrue(stateMachine.addAction('COFFEE', 'TOOMUCH', 'Add Coffee'));
			Assert.assertTrue(stateMachine.addAction('TOOMUCH', 'EMPTY', 'Start again'));
			Assert.assertTrue(stateMachine.addAction('ONSTOVE', 'MADE', 'Boil'));
			Assert.assertTrue(stateMachine.addAction('ONSTOVE', 'BROKEN', 'Forget'));
			Assert.assertTrue(stateMachine.addAction('MADE', 'CUP', 'Drink'));
			Assert.assertTrue(stateMachine.addAction('MADE', 'EMPTY', 'Spill'));
			Assert.assertTrue(stateMachine.addAction('CUP', 'EMPTY', 'More Coffee'));
			Assert.assertTrue(stateMachine.addAction('BROKEN', 'EMPTY', 'Buy New'));
			
			Assert.assertTrue(stateMachine.performAction('Add Cold Water'));
			Assert.assertTrue(stateMachine.performAction('Add Coffee'));
			Assert.assertTrue(stateMachine.performAction('Put On Stove'));
			Assert.assertTrue(stateMachine.performAction('Boil'));
			Assert.assertTrue(stateMachine.performAction('Spill'));
			Assert.assertFalse(stateMachine.performAction('Drink')); // Can't cup is empty
			Assert.assertTrue(stateMachine.performAction('Add Cold Water'));
			Assert.assertTrue(stateMachine.performAction('Add Coffee'));
			Assert.assertTrue(stateMachine.performAction('Add Coffee'));
			Assert.assertFalse(stateMachine.performAction('Put On Stove'));  // Can't added too much
			Assert.assertTrue(stateMachine.performAction('Start again'));
			Assert.assertTrue(stateMachine.performAction('Add Cold Water'));
			Assert.assertTrue(stateMachine.performAction('Add Coffee'));			
			Assert.assertTrue(stateMachine.performAction('Put On Stove'));
			Assert.assertTrue(stateMachine.performAction('Boil'));
			Assert.assertTrue(stateMachine.performAction('Drink')); // Can this time
		}
	}
}