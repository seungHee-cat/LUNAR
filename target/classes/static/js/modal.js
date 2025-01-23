// 중복생성 방지
if((typeof modal) == 'undefined')
{
    modal = {};
    /* -------------------------------------------------------
    * name	: openModal()
    * description	: 모달 열기
    ------------------------------------------------------- */
    modal.openModal = function(url, formData, size)
    {
        let modalId = 'base-modal';
        let modalElement = $(`#${modalId}`);

        if (modalElement.length === 0) {
            // 모달이 없다면, 새로운 모달 HTML을 생성
            $('body').append(`<div class="modal fade" id="${modalId}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                <div class="modal-dialog d-flex align-items-center justify-content-center" style="min-height: 90vh;">
                    <div class="modal-content"></div>
                </div>
            </div>`);
            modalElement = $(`#${modalId}`);
        }

        // 새로운 모달 열기
        let modalInstance = new bootstrap.Modal(modalElement);
        modalInstance.show();

        modalElement.one("shown.bs.modal",function(){
            $.ajax({
                url: url,
                type: "POST",
                data: formData,
                dataType: "html",
                processData: false,
                contentType: false,
                success: function (data) {
                    modalElement.find(".modal-content").html(data);

                    if (size === "small") {
                        $("#base-modal").removeClass("modal-lg").removeClass("modal-xl").addClass("modal-sm");
                    } else if (size === "medium") {
                        $("#base-modal").removeClass("modal-sm").removeClass("modal-lg").removeClass("modal-xl");
                    } else {
                        $("#base-modal").removeClass("modal-sm").removeClass("modal-lg").removeClass("modal-xl");
                    }
                },
                error: function () {
                    fn_showToastMessage("An error has occurred.");
                }
            });
        });
    };

    /* -------------------------------------------------------
    * name	: closeModal()
    * description	: 모달 닫기
    ------------------------------------------------------- */
    modal.closeModal = function()
    {
        const modalElement = $('#base-modal');
        const modalInstance = bootstrap.Modal.getInstance(modalElement[0]);

        if (modalInstance) {
            modalElement.one('hidden.bs.modal', function () {
                // 모달이 닫힌 후 관련 DOM 제거
                modalElement.remove(); // 모달 HTML 삭제
                $('.modal-backdrop').remove(); // 백드롭 삭제
                $('body').removeClass('modal-open'); // 스크롤 제어 클래스 제거
                $('body').css('padding-right', ''); // 추가된 패딩 초기화
            });

            modalInstance.hide(); // 모달 닫기
        }
    };

    /* -------------------------------------------------------
    * name	: closeModalWithToast(message)
    * description	: 모달 닫은 후 토스트 표시
    *
    ------------------------------------------------------- */
    modal.closeModalWithToast = function(message)
    {
        modal.closeModal();
        fn_showToastMessage(message);
    };

    /* -------------------------------------------------------
    * name	: closeModalAndReload(message)
    * description	: 모달 닫은 후 토스트 표시 및 새로고침 실행
    *
    ------------------------------------------------------- */
    modal.closeModalAndReload = function(message)
    {
        // 모달 닫기
        modal.closeModal();

        // 토스트 표시
        let toast = fn_showToastMessage(message);

        // 토스트 지속 시간 뒤 새로고침
        setTimeout(function() {
            location.reload();
        }, 1200); // 1.2초 뒤 새로고침
    };
}