package com.jdvn.devtech.datamodel.schema.transaction;

import java.util.Date;

import org.hibernate.annotations.Comment;

import com.jdvn.devtech.datamodel.schema.DomainObject;
import com.jdvn.devtech.datamodel.schema.application.Service;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "transaction", schema = "transaction", indexes = {
		@Index(name = "transaction_index_on_rowidentifier", columnList = "rowidentifier"),
		@Index(name = "transaction_status_code_fkey_ind", columnList = "status_code"),
		@Index(name = "transaction_from_service_id_fkey_ind", columnList = "from_service_id")})
@Comment("Each service initiates a transaction that is then recorded against any data edits made by the user. "
		+ "When the service is complete and the application approved, the data associated with the transction can be approved and updated as well."
		+ "If the user chooses to reject their changes prior to approval, the transaction can be used to determine which data edits need to be removed from the system without affecting the currently data.")
public class Transaction extends DomainObject<String> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(nullable = false, columnDefinition = "character varying(40) DEFAULT public.uuid_generate_v1()")
	private String id;

	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "from_service_id", referencedColumnName = "id", foreignKey = @ForeignKey(name = "transaction_from_service_id_fkey"))
	@Comment("The identifier of the service that initiated the transaction. NULL if the transaction has been created using other means. E.g. for migration or SETL, or plan of center goverment mass appraisals.")
    private Service service;
	
	@ManyToOne(fetch = FetchType.LAZY, optional = true)
    @JoinColumn(name = "status_code", referencedColumnName = "code", foreignKey = @ForeignKey(name = "transaction_status_code_fkey"))
	@Comment("The status of the transaction.")
    private TransactionStatusType transaction_status_type;
		
	@Column(columnDefinition = "timestamp without time zone")
	@Comment("The date and time the transaction is approved.")
	private Date approval_datetime;
	
	@Override
	public String print() {
		return id;
	}
	

}