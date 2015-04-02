//= require jquery
//= require jquery_ujs
//= require jquery.migrate
//= require jquery.mousewheel
//= require jquery.scrollpane
//= require jquery.core-ui-select
//= require jquery.nouislider.all
//= require jquery.countdown
//= require test/jquery.stickyNavbar
//= require_self

//$(document).on('click', '.b-catalogs__diameter-link', function(e){
//    e.preventDefault();
//    var d = $(this).data('diameter');
//    $('.js-diameter').removeClass('b-selection_transparent');
//    $('.js-diameter[data-d="'+d+'"]').addClass('b-selection_transparent');
//});


window.page = 1;

$(document).ready(function(){
    
    //Check to see if the window is top if not then display button
    $(window).scroll(function(){
        if ($(this).scrollTop() > 100) {
            $('.g-scrolltop').fadeIn();
        } else {
            $('.g-scrolltop').fadeOut();
        }
    });
    
    //Click event to scroll to top
    $('.g-scrolltop').click(function(){
        $('html, body').animate({scrollTop : 0},800);
        return false;
    });

    $(function () {
       $('.b-floathead').stickyNavbar({selector: 'li'});
    });
    // $('.g-navbar li').click(function(e){
        // $(this).find('a').click();
    // });
    // date = new Date(2015, 02-1, 31);
    now = new Date();
    local_action_time = new Date(localStorage.getItem('fake_action_time_sorry'));
    if ( local_action_time == null || local_action_time - now < 0 ){
        local_action_time = new Date(now.getTime() + 20*60*60000);
        localStorage.setItem('fake_action_time_sorry', local_action_time);
    }

    

    $('.b-header__counter-wrap').countdown({
        until: local_action_time,
        layout: $('.b-header__counter-wrap').html()
    });
});

$(document).on('click', '.b-catalogs__car-calc', function(e){
    e.preventDefault();
    get_disc_params($(this));
});

function get_disc_params(elem){
    var url = '/sizes/mod/'+elem.parent().find('.mods').find('option:selected').data('id')
    var _elem = elem;
    $.get(url).success(function(data){
        $e = $(_elem);
        $e.parent().parent().find('.b-catalogs__suggestions').html(data);
    });
}

$(document).on('click', '[data-params-setter]', function(){
  var size = $(this).data('size');
  if ($(this).data('tireParams')){
    $('#tpf .width').val(size.width);
    $('#tpf .height').val(size.height);
    $('#tpf .tyre-diameter').val(size.diameter);
    $("html, body").stop().animate({
                      scrollTop: $('.tyre-selection__more').offset().top + 2 + 'px'
                    });
    $('#dpf .b-catalogs__tyre-cat').click();   
  }else if ($(this).data('diskParams')){
    $('#dpf .width').val(size.width);   
    $('#dpf .diameter_diska').val(size.diameter);   
    $('#dpf .pcd').find('option[data-bolt-count="'+size.bolt_count+'"][data-bolt-distance="'+size.bolt_distance+'"]').attr('selected','selected')
    $('#dpf .et').val(size.et);   
    $('#dpf .diameter').val(size.di);   
    $('#dpf .b-catalogs__disk-cat').click();   
    $("html, body").stop().animate({
                      scrollTop: $('.b-selection__more').offset().top + 2 + 'px'
                    });
  }

  $('select').coreUISelect('update');
});

$(document).on('click', '.b-catalogs__disk-cat, .b-catalogs__diameter-link, .b-catalogs__find_disk', function(e){
  e.preventDefault();
  window.page = 1;
  window.d = undefined;
  $("html, body").stop().animate({
                  scrollTop: $('.b-selection__more').offset().top + 2 + 'px'
                });
  $('#dpf #page').remove();
  get_catalog(window.page, $(this));
});

$(document).on('click', '.b-selection__more-disks', function(e){
    e.preventDefault();
    window.page = window.page + 1;
    $('#dpf').append('<input id="page" name="page" value="'+window.page+'" type="hidden">');
    get_catalog(window.page, $(this));
});
$(document).on('click', '.b-selection__more-tires', function(e){
    e.preventDefault();
    window.page = window.page + 1;
    $('#tpf').append('<input id="page" name="page" value="'+window.page+'" type="hidden">');
    get_tyre_catalog(window.page, $(this));
});

$(document).on('click', '.b-catalogs__tyre-cat, .b-catalogs__find_tire', function(e){
  e.preventDefault();
  window.page = 1;
  window.d = undefined;
  $('#tpf #page').remove();
  $("html, body").stop().animate({
      scrollTop: $('.tyre-selection__more').offset().top + 2 + 'px'
    });
  get_tyre_catalog(window.page, $(this));
});

$(document).on('click', '.b-catalogs__find_disk', function(e){
    e.preventDefault();
    window.page = 1;
    window.d = undefined;
    get_catalog_extended(window.page, $(this));
});

function get_catalog_extended(page, self){
    // get_catalog
}
function get_catalog(page, self) {
    var additional_params;
    $('.b-catalogs__drop').css('display', 'block');

    window.params = {}

    if (self.data('d'))
      window.params.d = self.data('d');

    if (self.data('params')) {
      url = '/disks'

      if ($('.width').find('option:selected').data('id'))
        window.params.width = $('.width').find('option:selected').data('id')

      if ($('.diameter_diska').find('option:selected').data('id'))
        window.params.diameter_diska = $('.diameter_diska').find('option:selected').data('id')

      if ($('.pcd').find('option:selected').data('bolt-count') && $('.pcd').find('option:selected').data('bolt-distance'))
        window.params.bolt_count = $('.pcd').find('option:selected').data('bolt-count')
        window.params.bolt_distance = $('.pcd').find('option:selected').data('bolt-distance')

      if ($('.et').find('option:selected').data('id'))
        window.params.et = $('.et').find('option:selected').data('id')

      if ($('.diameter').find('option:selected').data('id'))
        window.params.diameter = $('.diameter').find('option:selected').data('id')

    } else {
      // alert('');
      url = '/disks/mod/'+self.parent().find('.mods').find('option:selected').data('id')
    }

    window.params.page = page

    console.log(window.params);
    additional_params = {};
    $('#dpf').serializeArray().map(function(item){
        additional_params[item.name] = item.value;
    })
    // $.get(url, $.extend(window.params,additional_params))
    $.rails.handleRemote($('#dpf'))
        .success(function(data){
            $('.b-catalogs__drop').delay(2000).css('display', 'none');
            $('.b-disk-selection__more').html(data);
            open_img();
            close_info();
            buy();
            reservation();
        })

        .fail(function(data){
            $('.b-catalogs__drop').delay(2000).css('display', 'none');
            $('.b-disk-selection__more').html(data);
        });

    
}
function get_tyre_catalog(page, self) {
    var additional_params;
    $('.b-catalogs__drop').css('display', 'block');

    window.params = {}

    if (self.data('d'))
      window.params.d = self.data('d');

    if (self.data('params')) {
      url = '/tires'

      if ($('#tpf .width').find('option:selected').data('id'))
        window.params.width = $('.width').find('option:selected').data('id')

      if ($('#tpf .height').find('option:selected').data('id'))
        window.params.height = $('.height').find('option:selected').data('id')

      if ($('#tpf .tyre-diameter').find('option:selected').data('id'))
        window.params.diameter = $('.tyre-diameter').find('option:selected').data('id')

      if ($('#tpf .season').find('option:selected').data('id'))
        window.params.diameter = $('.season').find('option:selected').data('id')
    }

    window.params.page = page

    console.log(window.params);
    additional_params = {};
    $('#tpf').serializeArray().map(function(item){
        additional_params[item.name] = item.value;
    })
    // $.get(url, $.extend(window.params,additional_params))
    $.rails.handleRemote($('#tpf'))
        .success(function(data){
            $('.b-catalogs__drop').delay(2000).css('display', 'none');
            $('.tyre-selection__more').html(data);
            open_img();
            close_info();
            buy();
            reservation();
        })

        .fail(function(data){
            $('.b-catalogs__drop').delay(2000).css('display', 'none');
            $('.tyre-selection__more').html(data);
        });
    
}

$(document).ready(function(){
    $('[data-click-empty]').focusin(function(){
        $(this).val('');
    });
    $('[data-click-empty]').focusout(function(){
        if ($(this).val() == ""){
            $(this).val($(this).data('clickEmpty'));
        }
    });
    $('.b-selection__more-center_button').click(function(e){
        e.preventDefault();

        var html = $('.b-selection__wrap_wrap').html();

        $('.b-selection__more').append(html);

        open_img();
        close_info();
        buy();
        reservation();
    });

    open_img();
    close_info();
    buy();
    reservation();

    $('#disk-price-bar, #tire-price-bar').noUiSlider({
        start: [ 1000, 100000 ],
        step: 200,
        margin: 20,
        connect: true,
        direction: 'ltr',
        orientation: 'horizontal',
        
        // Configure tapping, or make the selected range dragable.
        behaviour: 'tap-drag',
        
        // Full number format support.
        format: wNumb({
            mark: ',',
            decimals: 0
        }),
        
        // Support for non-linear ranges by adding intervals.
        range: {
            'min': 1000,
            'max': 100000
        }
    });

    $('#disk-price-bar').Link('lower').to($('#dpl'));
    $('#disk-price-bar').Link('upper').to($('#dph'));
    $('#tire-price-bar').Link('lower').to($('#tpl'));
    $('#tire-price-bar').Link('upper').to($('#tph'));
    $('.marks').coreUISelect({
        onChange: function(e){
            var $select = $(e);
            $.get('/mark/'+e.find('option:selected').data('id')+'/load_models')
                .success(function(data){
                    $select.parents('form').find('.models').removeAttr('disabled');
                    $select.parents('form').find('.years').attr('disabled', 'disabled');
                    $select.parents('form').find('.mods').attr('disabled', 'disabled');
                    $select.parents('form').find('.models').html(data);
                    $select.parents('form').find('.models').removeAttr('disabled');
                    $select.parents('form').find('.years, .mods').attr('disabled', true);
                    $select.parents('form').find('.models, .years, .mods').coreUISelect('update');
                })
                .fail(function(){
                    $select.parents('form').find('.models, .years, .mods').attr('disabled', true);
                    $select.parents('form').find('.models, .years, .mods').coreUISelect('update');
                });
        },

        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });

    $('.models').coreUISelect({
        onChange: function(e){;
            var $select = $(e);
            $.get('/model/'+e.find('option:selected').data('id')+'/load_years')
                .success(function(data){
                    $select.parents('form').find('.years').removeAttr('disabled');
                    $select.parents('form').find('.mods').attr('disabled', 'disabled');
                    $select.parents('form').find('.years').html(data);
                    $select.parents('form').find('.years').removeAttr('disabled');
                    $select.parents('form').find('.mods').attr('disabled', true);
                    $select.parents('form').find('.years, .mods').coreUISelect('update');
                })
                .fail(function(){
                    $select.parents('form').find('.years, .mods').attr('disabled', true);
                    $select.parents('form').find('.years, .mods').coreUISelect('update');
                });
        },

        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });

    $('.years').coreUISelect({
        onChange: function(e){
            var $select = $(e);
            $.get('/year/'+e.find('option:selected').data('id')+'/load_mods')
                .success(function(data){
                    $select.parents('form').find('.mods').removeAttr('disabled');
                    $select.parents('form').find('.mods').html(data);
                    $select.parents('form').find('.mods').removeAttr('disabled');
                    $select.parents('form').find('.mods').coreUISelect('update');
                })
                .fail(function(){
                    $select.parents('form').find('.mods').attr('disabled', true);
                    $select.parents('form').find('.mods').coreUISelect('update');
                });
        },

        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });

    $('.mods').coreUISelect({
        onChange: function(){},

        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });


    $('.width:not(.noui)').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });


    $('.diameter_diska').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });


    $('.pcd').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });


    $('.et').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });

    $('.diameter').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });

    $('.height:not(.noui), .tyre-diameter, .season').coreUISelect({
        jScrollPane: {
            verticalDragMinHeight: 20,
            verticalDragMaxHeight: 20,
            showArrows : true
        }
    });


    $('.b-selection__buy').click(function(e){
        e.preventDefault();
        $('.l-form').addClass('l-form_active_buy');
    });
    $('.b-selection__reservation').click(function(e){
        e.preventDefault();
        $('.l-form').addClass('b-form__header_reservation');
    });

    $('.b-form__close').click(function(e){
        e.preventDefault();

        $('.l-form').removeClass('l-form_active_buy');
        $('.l-form_finished').addClass('l-form_finished_hide');
        $('.l-form').removeClass('b-form__header_reservation');
    });



    $('.b-form__submit').click(function(e){
        e.preventDefault();
        $('.b-form__submit_hidden').click();
    });
});


function open_img(){
    $('.b-hit__img').click(function(e){
        e.preventDefault();

        $('.b-hit__wrap').removeClass('b-hit__wrap_active');
        $('.b-selection__wrap').removeClass('b-selection__wrap_active');

        $(this).parent().addClass('b-hit__wrap_active');
        $(this).parent().parent().parent().parent().addClass('b-selection__wrap_active');

        var figure = $(this).data('figure');

        $('#figure-'+figure+' .image').attr('src', $(this).data('image'));
        $('#figure-'+figure+' .name').text($(this).data('name'));
        $('#figure-'+figure+' .width').text($(this).data('width'));
        $('#figure-'+figure+' .diametr').text($(this).data('diametr'));
        $('#figure-'+figure+' .boom').text($(this).data('boom'));
        $('#figure-'+figure+' .fixture').text($(this).data('fixture'));
        $('#figure-'+figure+' .hole').text($(this).data('hole'));
        $('#figure-'+figure+' .new-price').text($(this).data('new-price'));
        $('#figure-'+figure+' .color').text($(this).data('color'));
        $('#figure-'+figure+' .height').text($(this).data('height'));

        $(window).scrollTop($(this).offset().top-85, 800);
    });
}

function close_info(){
    $('.b-selection__info-close').click(function(e){
        e.preventDefault();

        $(this).parent().parent().parent().parent().removeClass('b-selection__wrap_active');
        $('.b-hit__wrap').removeClass('b-hit__wrap_active');
    });
}

function buy(){
    $('.b-selection__buy').click(function(e){
        e.preventDefault();
        $('.l-form').addClass('l-form_active_buy');
        $('.l-form_finished').addClass('l-form_finished_hide');
        $('#disk-id').val($(this).data('id'));
        $('#order-type').val($(this).data('type'));

    });
}

function reservation(){
    $('.b-selection__reservation').click(function(e){
        e.preventDefault();
        $('.l-form').addClass('b-form__header_reservation');
        $('.l-form_finished').addClass('l-form_finished_hide');
        $('#disk-id').val($(this).data('id'));
    });
}
