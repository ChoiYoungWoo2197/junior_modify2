package kr.or.domain;

public class Page {
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	private SearchCriteria criteria;
	
	public Page(int total, SearchCriteria criteria) {
		this.total = total;
		this.criteria = criteria;
		this.endPage = (int) ((Math.ceil(criteria.getPage() / 10.0)) * 10); //ceil은 올림처리 => Math.ceil(0.1)*10 = 10 , Math.ceil(1.1)*10 = 20
		this.startPage = this.endPage -9; //끝에서 9를 빼면 페이지 시작번호
		
		//끝번호는 전체 데이터 수에 영향을 받기 때문에 끝번호와 페이지당 출력되는 데이터 수의 곱이 전체 데이터수보다 크다면 끝번호는 새로 계산되어야 된다.
		int realEnd = (int) (Math.ceil((total * 1.0) / criteria.getAmount())); 
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		this.prev = this.startPage > 1; //시작번호가 1보다 크면 존재해야 된다.
		this.next = this.endPage < realEnd; //realEnd가 끝번호보다 큰 경우에만 존재해야 된다.
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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public SearchCriteria getCriteria() {
		return criteria;
	}

	public void setCriteria(SearchCriteria criteria) {
		this.criteria = criteria;
	}
}
