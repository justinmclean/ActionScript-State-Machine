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

package flexUnitTests
{
	import com.classsoftware.history.History;
	import org.flexunit.Assert;
	
	public class HistoryTest
	{
		private var history:History;
		
		[Before]
		public function setUp():void
		{
			history = new History();
			history.save("one");
			history.save("two");
		}
		
		[Test]
		public function current():void {		
			Assert.assertEquals(history.getCurrent(), "two");
			Assert.assertEquals(history.getPrevious(), "one");
			Assert.assertEquals(history.getNext(), null);
			Assert.assertTrue(history.isPrevious());
			Assert.assertFalse(history.isNext());
		}
		
		[Test]
		public function previous():void {
			Assert.assertTrue(history.previous());
			Assert.assertFalse(history.previous());
			
			Assert.assertEquals(history.getCurrent(), "one");
			Assert.assertEquals(history.getPrevious(), null);
			Assert.assertEquals(history.getNext(), "two");
			Assert.assertFalse(history.isPrevious());
			Assert.assertTrue(history.isNext());
		}
		
		[Test]
		public function next():void {
			Assert.assertTrue(history.previous());
			Assert.assertTrue(history.next());
			Assert.assertFalse(history.next());
			
			Assert.assertEquals(history.getCurrent(), "two");
			Assert.assertEquals(history.getPrevious(), "one");
			Assert.assertEquals(history.getNext(), null);
			Assert.assertTrue(history.isPrevious());
			Assert.assertFalse(history.isNext());			
		}
		
		[Test]
		public function reset():void {
			history.reset();
			
			Assert.assertEquals(history.getCurrent(), null);
			Assert.assertEquals(history.getPrevious(), null);
			Assert.assertEquals(history.getNext(), null);
			Assert.assertFalse(history.isPrevious());
			Assert.assertFalse(history.isNext());			
		}
	}
}