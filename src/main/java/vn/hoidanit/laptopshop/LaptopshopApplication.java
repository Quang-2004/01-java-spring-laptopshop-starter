package vn.hoidanit.laptopshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class LaptopshopApplication {

	public static void main(String[] args) {
		
		// container
		ApplicationContext quang = SpringApplication.run(LaptopshopApplication.class, args);
		// for(String s: quang.getBeanDefinitionNames()){
		// 	System.out.println(s);
		// }
	}

}

