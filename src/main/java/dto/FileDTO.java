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
		File f = null;
		Path path = null;
		f = new File(location);
		path = Path.of(location);
		this.name = path.getFileName().toString();
		try {
			FileInputStream  inputStreamFromFile= new FileInputStream(f);
			this.data = inputStreamFromFile.readAllBytes();
			inputStreamFromFile.close();
		} catch (IOException e) {
			this.data = new byte[0];
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
