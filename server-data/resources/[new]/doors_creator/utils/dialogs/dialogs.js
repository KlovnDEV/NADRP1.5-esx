function jobsDialog(oldJobs) {
	return new Promise((resolve, reject) => {
		let inputJobsModal = $("#input-jobs-dialog-modal")
		inputJobsModal.modal("show");
	
		$("#input-job-search").val("");
		
		$.post(`https://${resName}/getAllJobs`, JSON.stringify({}), function (jobs) {
			let jobListDiv = $("#jobs-list");
	
			jobListDiv.empty();
	
			for(const[jobName, jobData] of Object.entries(jobs)) {
				let jobDiv = $(`
					<div class="form-check fs-3 mb-2">
						<input class="form-check-input" data-type="job" type="checkbox" data-job-name="${jobName}">

						<p class="fw-bold mb-0">${jobData.label}</p>
						
						<div class="job-grades ms-3">
	
						</div>
					</div>
				`);
	
				for(let [grade, gradeData] of Object.entries(jobData.grades)) {
					// QB-Core
					if(gradeData.grade == undefined) {
						gradeData.grade = grade;
						gradeData.label = gradeData.name;
					}

					let rankDiv = $(`
						<div class="rank-div">
							<input class="form-check-input" data-type="job-grade" type="checkbox" data-job-name="${jobName}" data-grade=${gradeData.grade}>
							<label class="form-check-label">
								${gradeData.grade} - ${gradeData.label}
							</label>
						</div>
					`);
	
					jobDiv.find(".job-grades").append(rankDiv);
				}
	
				jobListDiv.append(jobDiv);
			}

			// Disables and uncheck grades checkbox if the entire job is selected
			$("#jobs-list").find(`[data-type="job"]`).change(function() {
				let isChecked = $(this).prop("checked");

				if(isChecked) {
					$(this).parent().find(".job-grades").find("input").prop("checked", false).prop("disabled", true);
				} else {
					$(this).parent().find(".job-grades").find("input").prop("disabled", false);
				}
			})
	
			if(oldJobs) {
				for(let [jobName, allowedGrades] of Object.entries(oldJobs)) {
					if(allowedGrades === true) {
						$("#jobs-list").find(`[data-type="job"][data-job-name="${jobName}"]`).prop("checked", true).change();
					} else {
						for(let [grade, _] of Object.entries(allowedGrades)) {
							$("#jobs-list").find(`[data-type="job-grade"][data-job-name="${jobName}"][data-grade="${grade}"]`).prop("checked", true);
						}
					}
				}
			}

			// Unbinds the button and rebinds it to callback the selected jobs
			$("#input-jobs-confirm-btn").unbind().click(function() {
				let selectedJobs = {};
	
				let isThereAnyJob = false;
	
				jobListDiv.find("input:checked").each(function() {
					let checkBoxType = $(this).data("type");
					isThereAnyJob = true;
	
					let jobName = $(this).data("jobName");

					switch(checkBoxType) {
						case "job":
							selectedJobs[jobName] = true;
							break;
						case "job-grade":
							let grade = $(this).data("grade");
	
							if(!selectedJobs[jobName]) {
								selectedJobs[jobName] = {};
							}
							
							selectedJobs[jobName][grade] = true;
							break;
						default:
							console.log("Unknown checkbox type: " + checkBoxType + " in jobs dialog");
							break;
					}
				});
	
				inputJobsModal.modal("hide");
	
				resolve(isThereAnyJob ? selectedJobs : false);
			})
		});
	})
}
$("#input-job-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#jobs-list .form-check").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
})

function gangsDialog(oldGangs) {
	return new Promise((resolve, reject) => {
		let inputGangsModal = $("#input-gangs-dialog-modal")
		inputGangsModal.modal("show");
	
		$("#input-gang-search").val("");
		
		$.post(`https://${resName}/getAllGangs`, JSON.stringify({}), function (gangs) {
			let gangListDiv = $("#gangs-list");
	
			gangListDiv.empty();
	
			for(const[gangName, gangData] of Object.entries(gangs)) {
				let gangDiv = $(`
					<div class="form-check fs-3 mb-2">
						<input class="form-check-input" data-type="gang" type="checkbox" data-gang-name="${gangName}">

						<p class="fw-bold mb-0">${gangData.label}</p>
						
						<div class="gang-grades ms-3">
	
						</div>
					</div>
				`);
	
				for(let [grade, gradeData] of Object.entries(gangData.grades)) {
					// QB-Core
					if(gradeData.grade == undefined) {
						gradeData.grade = grade;
						gradeData.label = gradeData.name;
					}

					let rankDiv = $(`
						<div class="rank-div">
							<input class="form-check-input" data-type="gang-grade" type="checkbox" data-gang-name="${gangName}" data-grade=${gradeData.grade}>
							<label class="form-check-label">
								${gradeData.grade} - ${gradeData.label}
							</label>
						</div>
					`);
	
					gangDiv.find(".gang-grades").append(rankDiv);
				}
	
				gangListDiv.append(gangDiv);
			}

			// Disables and uncheck grades checkbox if the entire gang is selected
			$("#gangs-list").find(`[data-type="gang"]`).change(function() {
				let isChecked = $(this).prop("checked");

				if(isChecked) {
					$(this).parent().find(".gang-grades").find("input").prop("checked", false).prop("disabled", true);
				} else {
					$(this).parent().find(".gang-grades").find("input").prop("disabled", false);
				}
			})
	
			if(oldGangs) {
				for(let [gangName, allowedGrades] of Object.entries(oldGangs)) {
					if(allowedGrades === true) {
						$("#gangs-list").find(`[data-type="gang"][data-gang-name="${gangName}"]`).prop("checked", true).change();
					} else {
						for(let [grade, _] of Object.entries(allowedGrades)) {
							$("#gangs-list").find(`[data-type="gang-grade"][data-gang-name="${gangName}"][data-grade="${grade}"]`).prop("checked", true);
						}
					}
				}
			}

			// Unbinds the button and rebinds it to callback the selected gangs
			$("#input-gangs-confirm-btn").unbind().click(function() {
				let selectedGangs = {};
	
				let isThereAnyGang = false;
	
				gangListDiv.find("input:checked").each(function() {
					let checkBoxType = $(this).data("type");
					isThereAnyGang = true;
	
					let gangName = $(this).data("gangName");

					switch(checkBoxType) {
						case "gang":
							selectedGangs[gangName] = true;
							break;
						case "gang-grade":
							let grade = $(this).data("grade");
	
							if(!selectedGangs[gangName]) {
								selectedGangs[gangName] = {};
							}
							
							selectedGangs[gangName][grade] = true;
							break;
						default:
							console.log("Unknown checkbox type: " + checkBoxType + " in gangs dialog");
							break;
					}
				});
	
				inputGangsModal.modal("hide");
	
				resolve(isThereAnyGang ? selectedGangs : false);
			})
		});
	})
}
$("#input-gang-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#gangs-list .form-check").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
})