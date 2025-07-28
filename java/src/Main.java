import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        // instancia Gson
        Gson gson = new Gson();

        // recebe o caminho do arquivo que será lido
        Reader reader = new FileReader("C:\\json-to-fixed-format\\usuarios.json");

        // transforma em uma lista utilizando o TypeToken para poder continuar com o tipo da lista
        Type listType = new TypeToken<List<UserData>>(){}.getType();
        List<UserData> users = gson.fromJson(reader, listType);

        // cria uma lista para adicionar os objetos criados
        List<UserData> convertedList = new ArrayList<>();

        // passa cada usuario do arquivo json para um objeto
        users.forEach(user -> {
            UserData newUser = new UserData();
            newUser.setName(user.getName());
            newUser.setEmail(user.getEmail());
            newUser.setBalance(user.getBalance());

            convertedList.add(newUser);
        });

        // Instancia a classe para escrever o arquivo txt
        BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\json-to-fixed-format\\usuarios.txt"));

        for (UserData userData : convertedList) {
            String line = String.format("%-15s%-30s%06.2f",
                            userData.getName(),
                            userData.getEmail(),
                            userData.getBalance());

            writer.write(line);
            writer.newLine();
        }

        writer.close();
    }
}
