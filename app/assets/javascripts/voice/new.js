$(window).on('load', function(){
    $('input[name="voice[url]"]').change(function(){
        $.post('/timed_text/',
            {
                url: $('input[name="voice[url]"]').val()
            },
            function(data) {

                $(data).find('text').each(function(index){
                    $('#js-xmlArea').append(
                        '<tr id="line-' + index + '">' +
                        '<td class="start">' +
                        $(this).attr('start') + '</td>' +
                        '<td class="during">' +
                        $(this).attr('dur') + '</td>' +
                        '<td class="line">' +
                        $(this).text() + '</td></tr>');
                });
            },
            'xml');
    });

    var observer = new MutationObserver(function(){
        $('[id^=line]').on('click', function(event){
            // shiftクリック or metaクリックで結合
            if (event.shiftKey || event.metaKey) {
                $(this).toggleClass('info');
                if (!$('#js-line').val()) {
                    return;
                }
                $('#js-line').val(
                    $('#js-line').val() + ' ' +
                    $(this).find('.line').text()
                );
                $('input[name="voice[during]"]').val(
                    parseFloat($('input[name="voice[during]"]').val()) +
                    parseFloat($(this).find('.during').text())
                );
            } else {
                $('#js-xmlArea').find('tr').removeClass('info');
                $(this).toggleClass('info');
                $('#js-line').val(
                    $(this).find('.line').text()
                );
                $('input[name="voice[start]"]').val(
                    $(this).find('.start').text()
                );
                $('input[name="voice[during]"]').val(
                    $(this).find('.during').text()
                );
            }
        });
    });


    observer.observe($('#js-xmlArea').get(0), {
        childList: true,
    });

});