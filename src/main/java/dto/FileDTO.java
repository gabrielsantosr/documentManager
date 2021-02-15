package dto;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Path;

public class FileDTO {
	
	//Spring automatically converts the array of bytes into Base64.
	private byte[] data;
	private String name;
	
	public FileDTO(String location) {
		File f = new File(location);
		Path path = Path.of(location);
		this.name = path.getFileName().toString();
		
		try {
			FileInputStream  inputStreamFromFile= new FileInputStream(f);
			this.data = inputStreamFromFile.readAllBytes();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public byte[] getData() {
		return data;
	}

	public void setData(byte[] data) {
		this.data = data;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
