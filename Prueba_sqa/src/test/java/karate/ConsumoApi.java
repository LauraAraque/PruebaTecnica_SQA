package karate;

import com.intuit.karate.junit5.Karate;

public class ConsumoApi {
    @Karate.Test
    Karate testReq() {
        return Karate.run("consumo_api").relativeTo(getClass());
    }
}
