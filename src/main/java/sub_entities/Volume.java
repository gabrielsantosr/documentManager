package sub_entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class Volume {
	@Column(name="vol_number", length=8)
	private String volumeNumber;
	
	@Column(name="vol_release", length=8)
	private String volumeRelease;
	
	
	public Volume() {
	}

	public Volume(String volumeNumber, String volumeRelease) {
		this.volumeNumber = volumeNumber;
		this.volumeRelease = volumeRelease;
	}

	public String getVolumeNumber() {
		return volumeNumber;
	}

	public void setVolumeNumber(String volumeNumber) {
		this.volumeNumber = volumeNumber;
	}

	public String getVolumeRelease() {
		return volumeRelease;
	}

	public void setVolumeRelease(String volumeRelease) {
		this.volumeRelease = volumeRelease;
	}

}
