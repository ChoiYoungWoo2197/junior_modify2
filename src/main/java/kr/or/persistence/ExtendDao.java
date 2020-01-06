package kr.or.persistence;

import kr.or.domain.Extend;

public interface ExtendDao {
	public void insertExtendByMap(Extend extand);
	public Extend searchExtendReasonById(int reservationId);
}
