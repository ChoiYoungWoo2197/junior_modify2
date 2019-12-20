package kr.or.domain;

public class PageMaker {
	private int totalCount; //게시글 전체갯수
	private int startPage; //현재 보이는 페이지 시작 번호 ★
	private int endPage; //현재 보이는 페이지 끝 번호 ★
	private boolean prev; //이전 10개 존재여부 ★
	private boolean next; //이후 10개 존재여부 ★
	private int displayPageNum = 10; //보이는 페이지번호 갯수
	private Criteria criteria;
	
	private void calData() {
		//현재 페이지의 끝 번호를 구한다.
		endPage = (int) (Math.ceil(criteria.getPage() / (double)displayPageNum) * displayPageNum); //ex) 지금 페이지가 15
																						      //15 / 10 = 1.5 => 2(ceil은 올림이니까) * 10 = 20.
																							  //따라서 지금 페이지가 15라면 끝 페이지는 20
		
		//현재 페이지의 시작 번호를 구한다.
		startPage = (endPage - displayPageNum) + 1; //ex) 20 - 10 = 10 + 1 = 11
		
		int tempEndPage = (int) (Math.ceil(totalCount / (double)criteria.getPerPageNum())); //ex) totalCount = 151개로 가정
																					   //cri.getPerPageNum() : 한 페이지 당 보여질 게시글 개수
																					   //전체 게시글이 151개이고 현재 페이지가 15일 때, 마지막 end는 16으로 나타나야한다.
																					   //151 / 10 = 15.1 => 16
		
		//끝 페이지 번호가 실제 끝 번호보다 크다면 변경해준다.
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//이전페이지 여부
		if(startPage == 1) {
			prev = false;
		}else {
			prev = true;
		}
		
		//다음페이지 여부
		if(endPage * criteria.getPerPageNum() >= totalCount) {
			next = false;
		}else {
			next = true;
		}
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calData(); //이 함수를 사용하려면 totalCount가 있어야 하니까 totalCount를 set하는 여기에다가 함수를 호출하도록 해주는거지
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public Criteria getCriteria() {
		return criteria;
	}
	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}
	
}
