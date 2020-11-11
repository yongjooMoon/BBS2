package bbs;

public class s {
	public void testFunction() {
	int count =0;
	int result = 33;
	int div = 10;
	if(result%div != 0){
		count = result/div;
	}else {
		count = (result/div) + 1;
	}
	for(int i =1;i<=count;i++){
		System.out.println(i);
	}
	}
}