package inventory.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import inventory.model.Supplier;

@Repository
@Transactional(rollbackFor = Exception.class)
public class SupplierDAOImpl extends BaseDAOImpl<Supplier> implements SupplierDAO<Supplier> {

}
