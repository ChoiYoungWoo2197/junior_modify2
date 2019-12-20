package kr.or.domain;

public class Criteria {	//페이지를 체크하려면 계속 페이지 정보를 들고 다녀야 되는데, 쉽게 들고다니기 위해 클래스를 생성해줌
	private int page; //페이지번호
	private int perPageNum; //페이지당 보이는 게시글 갯수
	
	public Criteria() {
		page = 1;
		perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	
}
