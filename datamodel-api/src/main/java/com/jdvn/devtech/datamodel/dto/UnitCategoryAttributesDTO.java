package com.jdvn.devtech.datamodel.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class UnitCategoryAttributesDTO {
	@JsonProperty private String code;
    @JsonProperty private String name;
    @JsonProperty private String description;
    @JsonProperty private String status;
}