/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class ApexTest {
	static testmethod void testAccountTask(){
		
		Account accNew = new Account(Name='abc');
		accNew.Phone = '9405791062';
		accNew.Email_Id__c = 'ripalpatel52@gmail.com';
		insert accNew;
		
		try{
			Contact cntNew = new Contact(FirstName='abc');
			cntNew.LastName = 'dakljd';
			cntNew.Phone = '654321854';
			cntNew.Email = 'ripalpatel52@gmail.com';
			cntNew.AccountId = accNew.id;
			insert cntNew;
			
			cntNew = new Contact(FirstName='abc');
			cntNew.LastName = 'dakljd';
			cntNew.Phone = '6543218544';
			cntNew.Email = 'ripalpatel52@gmail.com';
			cntNew.AccountId = accNew.id;
			insert cntNew;
		}
		catch(DMLException ex){
			System.debug('An error has occured, contact the admin');
		}
		
		try{	
			Contact cntNew = new Contact(FirstName='abc');
			cntNew = new Contact(FirstName='abc');
			cntNew.LastName = 'dakljd';
			cntNew.Phone = '654321854';
			cntNew.Email = 'ripalpatel52@gmail.com';
			cntNew.AccountId = accNew.id;
			insert cntNew;
		}
		catch(DMLException ex){
			System.debug('An error has occured, contact the admin');
		}
		
		Campaign newCampaign = new Campaign(Name='Dummy Campaign');
		insert newCampaign;
		
		Lead newLead = new Lead(LastName='Joshi',Status='Open - Not Contacted', RSVP__c = 'Hello', Company = 'SyntaxSofts Inc.');
		insert newLead;
		
		CampaignMember cm = new CampaignMember(CampaignId = newCampaign.Id, LeadId = newLead.Id);
		insert cm;
		
		test.startTest();
		
		List<Account>lstNewAcc = new List<Account>();
		List<Contact>lstNewCont = new List<Contact>();
		
		for(Integer i=0;i<195;i++){
			Account acc = new Account(Name='abc' + String.valueOf(i));
			acc.Phone = '9405791062';
			acc.Email_Id__c = 'ripalpatel52@gmail.com';
			lstNewAcc.add(acc);
			
			Contact cnt = new Contact(FirstName='abc' + String.valueOf(i));
			cnt.LastName = 'dakljd' + String.valueOf(i);
			cnt.Phone = String.valueOf(i+100);
			cnt.Email = 'ripalpatel52@gmail.com' + String.valueOf(i);
			cnt.AccountId = acc.Id;
			lstNewCont.add(cnt);
		}
		insert lstNewCont;
		insert lstNewAcc;
		
		List<Account>lstInsert = [SELECT a.Name FROM Account a];
		List<Task>lstTask = [SELECT t.Subject FROM Task t];
		system.assertEquals(lstInsert.size(), lstTask.size());
		
		test.stopTest();
	}
}