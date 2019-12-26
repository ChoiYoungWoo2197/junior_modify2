package kr.or.domain;

public class SearchCriteria {
	private int page; //페이지번호
	private int amount; //페이지당 몇개의 데이터를 보여줄 것인가?
	private String searchType; //검색타입
	private String searchContent; //검색내용
	
	public SearchCriteria(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	public SearchCriteria() {
		this(1, 10);
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchContent() {
		return searchContent;
	}
	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}
	public int getPageStart() {
		return (this.page - 1) * amount;
	}
}
