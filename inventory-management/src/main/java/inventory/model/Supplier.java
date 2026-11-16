package inventory.model;

import java.util.Date;

/**
 * Supplier - Nhà cung cấp
 */
public class Supplier implements java.io.Serializable {

	private Integer id;
	private String name;
	private String code;
	private String description;
	private String phone;
	private String email;
	private String address;
	private int activeFlag;
	private Date createDate;
	private Date updateDate;

	public Supplier() {
	}

	public Supplier(String name, String code, int activeFlag, Date createDate, Date updateDate) {
		this.name = name;
		this.code = code;
		this.activeFlag = activeFlag;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	public Supplier(String name, String code, String description, String phone, String email, String address,
			int activeFlag, Date createDate, Date updateDate) {
		this.name = name;
		this.code = code;
		this.description = description;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.activeFlag = activeFlag;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getActiveFlag() {
		return this.activeFlag;
	}

	public void setActiveFlag(int activeFlag) {
		this.activeFlag = activeFlag;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "Name =" + name + " Code= " + code + " description=" + description;
	}

}
