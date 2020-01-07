package kr.or.domain;

public class SearchCriteria {
	private int page; //페이지번호
	private int amount; //페이지당 몇개의 데이터를 보여줄 것인가?
	private String searchType; //검색타입
	private String searchContent; //검색내용
	//예약내역에서 검색할 때 필요
	private String state;
	private String meetingRoomId;
	private String searchStart;
	private String searchEnd;
	
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getMeetingRoomId() {
		return meetingRoomId;
	}
	public void setMeetingRoomId(String meetingRoomId) {
		this.meetingRoomId = meetingRoomId;
	}
	public String getSearchStart() {
		return searchStart;
	}
	public void setSearchStart(String searchStart) {
		this.searchStart = searchStart;
	}
	public String getSearchEnd() {
		return searchEnd;
	}
	public void setSearchEnd(String searchEnd) {
		this.searchEnd = searchEnd;
	}
}
