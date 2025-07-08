package richardthunder.chatapp.controller;

import dev.langchain4j.service.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import richardthunder.chatapp.model.Assistant;

@RestController
@RequestMapping("/api/v1/assistant")
public class AssistantController {


    private final Assistant assistant;

    public AssistantController(Assistant assistant) {
        this.assistant = assistant;
    }

    @GetMapping("/chat")
    public String chat(@RequestParam(value = "message", required = true) String message){
         return assistant.chat(message);
    }
}
