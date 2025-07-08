package richardthunder.chatapp.model;

import dev.langchain4j.service.SystemMessage;
import dev.langchain4j.service.spring.AiService;


@AiService
public interface Assistant {
    @SystemMessage("you are a helpful assistant")
    String chat(String message);
}