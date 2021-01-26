package tests;

public class ListTest {

	public static void main(String[] args) {

		Hijo test = new Hijo();
		System.out.println(test);
		test.setApellido("Esnaola");
		System.out.println(test);
		System.out.println((Hijo)test);
		System.out.println(test.toString());
		System.out.println(((Hijo)test).getApellido());
		
		
	}

}
