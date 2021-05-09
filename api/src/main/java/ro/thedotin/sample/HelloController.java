package ro.thedotin.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("hello")
public class HelloController {

    private final String helloName;

    @Autowired
    public HelloController(@Value("${hello}") String helloName){
        this.helloName = helloName;
    }

    @GetMapping
    public String sayHello(){
        return "Hello, "+ this.helloName;
    }
}