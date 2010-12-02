package flexUnitTests
{
	import com.classsoftware.statemachine.EventStateMachine;
	import com.classsoftware.statemachine.HistoryStateMachine;
	import com.classsoftware.statemachine.StateMachine;
	import com.classsoftware.statemachine.interfaces.IStateMachine;
	
	import flash.events.Event;
	
	import org.flexunit.Assert;

	public class HistoryStateMachineTest
	{	
		private var stateMachine:HistoryStateMachine;
		
		[Before]
		public function setUp():void
		{
			stateMachine = new HistoryStateMachine(new StateMachine());
		}
		
		[Test]
		public function history():void {
			// action and next is valid
			Assert.assertTrue(stateMachine.addAction('ONE', 'TWO', 'Next'));
			Assert.assertTrue(stateMachine.addAction('TWO', 'THREE', 'Next'));
			Assert.assertTrue(stateMachine.addAction('THREE', 'FOUR', 'Next'));
			Assert.assertTrue(stateMachine.addAction('FOUR', 'FIVE', 'Next'));
			
			// previous is valid
			Assert.assertTrue(stateMachine.addAction('FIVE', 'FOUR', 'Prev'));
			Assert.assertTrue(stateMachine.addAction('FOUR', 'THREE', 'Prev'));
			Assert.assertTrue(stateMachine.addAction('THREE', 'TWO', 'Prev'));
			Assert.assertTrue(stateMachine.addAction('TWO', 'ONE', 'Prev'));			
			
			Assert.assertTrue(stateMachine.performAction('Next'));
			Assert.assertTrue(stateMachine.performAction('Next'));
			Assert.assertTrue(stateMachine.performAction('Next'));
			Assert.assertTrue(stateMachine.performAction('Next'));
			Assert.assertEquals(stateMachine.currentState(), 'FIVE');
			Assert.assertTrue(stateMachine.previous());
			Assert.assertEquals(stateMachine.currentState(), 'FOUR');
			Assert.assertTrue(stateMachine.previous());
			Assert.assertEquals(stateMachine.currentState(), 'THREE');
			Assert.assertTrue(stateMachine.previous());
			Assert.assertEquals(stateMachine.currentState(), 'TWO');
			Assert.assertTrue(stateMachine.previous());
			Assert.assertEquals(stateMachine.currentState(), 'ONE');
			Assert.assertFalse(stateMachine.previous()); // con't do this
			Assert.assertTrue(stateMachine.next());
			Assert.assertEquals(stateMachine.currentState(), 'TWO');
			Assert.assertTrue(stateMachine.next());
			Assert.assertEquals(stateMachine.currentState(), 'THREE');
			Assert.assertTrue(stateMachine.next());
			Assert.assertEquals(stateMachine.currentState(), 'FOUR');
			Assert.assertTrue(stateMachine.next());
			Assert.assertEquals(stateMachine.currentState(), 'FIVE');
			Assert.assertFalse(stateMachine.next()); // can't do this
			Assert.assertTrue(stateMachine.previous());
			Assert.assertTrue(stateMachine.previous());
			Assert.assertTrue(stateMachine.performAction('Next'));
			Assert.assertEquals(stateMachine.currentState(), 'FOUR');
		}
		
	}
}