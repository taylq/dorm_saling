/**
 * isMobile
 * responsiveMenu
 * menuDesktop
 * headerFixed
 * onepage_nav
 * onepage_section
 * ajaxContactForm
 * projectsSlider
 * flatTestimonial
 * flatSliderSidebars
 * detectViewport
 * flatCounter
 * googleMap
 * popupGallery
 * portfolioIsotope
 * shopTabs
 * goTop
 * flatFilterPrice
 * retinaLogos
 * parallax
 * removePreloader
 */
;
(function($) {

    'use strict'

    var isMobile = {
        Android: function() {
            return navigator.userAgent.match(/Android/i);
        },
        BlackBerry: function() {
            return navigator.userAgent.match(/BlackBerry/i);
        },
        iOS: function() {
            return navigator.userAgent.match(/iPhone|iPad|iPod/i);
        },
        Opera: function() {
            return navigator.userAgent.match(/Opera Mini/i);
        },
        Windows: function() {
            return navigator.userAgent.match(/IEMobile/i);
        },
        any: function() {
            return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
        }
    };

    var responsiveMenu = function() {
        var menuType = 'desktop';

        $(window).on('load resize', function() {
            var currMenuType = 'desktop';
            if (matchMedia('only screen and (max-width: 1199px)').matches) {
                currMenuType = 'mobile';
            }

            if (currMenuType !== menuType) {
                menuType = currMenuType;

                if (currMenuType === 'mobile') {
                    var $mobileMenu = $('#mainnav').attr('id', 'mainnav-mobi').hide();
                    var hasChildMenu = $('#mainnav-mobi').find('li:has(ul)');

                    $('.mega-menu .mega-menu-sub').hide();
                    $('.has-mega-menu .submenu.mega-menu').hide();

                    $('#header').after($mobileMenu);
                    hasChildMenu.children('ul').hide();
                    hasChildMenu.children('a:not(.has-mega)').after('<span class="btn-submenu"></span>');
                    $('.btn-menu').removeClass('active');
                } else {
                    var $desktopMenu = $('#mainnav-mobi').attr('id', 'mainnav').removeAttr('style');

                    $desktopMenu.find('.submenu').removeAttr('style');
                    $('#header').find('.nav-wrap').append($desktopMenu);
                    $('.btn-submenu').remove();
                }
            }
        });

        $('.btn-menu').on('click', function() {
            $('#mainnav-mobi').slideToggle(300);
            $(this).toggleClass('active');
        });

        // Mega menu click
        if (matchMedia('only screen and (max-width: 991px)').matches) {
            $('.btn-mega').on('click', function() {
                $(this).parent('.mega-title').siblings().slideToggle(300);
                $(this).toggleClass('active');
            });

            $('.has-mega').on('click', function() {
                $(this).siblings().slideToggle(300);
                $(this).removeClass('active').toggleClass('flat-active');
            });
        }

        $(document).on('click', '#mainnav-mobi li .btn-submenu', function(e) {
            $(this).toggleClass('active').next('ul').slideToggle(300);
            e.stopImmediatePropagation()
        });

    }

    var menuDesktop = function() {
        $('.btn-menu-desk').on('click', function() {
            $(this).toggleClass('active');
            $(this).siblings('.menu').toggleClass('active');
        });
    }

    var headerFixed = function() {
        if ($('body').hasClass('header-sticky')) {
            var nav = $('.header');

            if (nav.size() != 0) {
                var offsetTop = $('.header').offset().top,
                    headerHeight = $('.header').height(),
                    injectSpace = $('<div />', {
                        height: headerHeight
                    }).insertAfter(nav);
                injectSpace.hide();

                $(window).on('load scroll', function() {
                    if ($(window).scrollTop() > 0) {
                        $('.header').addClass('header-fix');
                        injectSpace.show();
                    } else {
                        $('.header').removeClass('header-fix');
                        injectSpace.hide();
                    }
                })
            }
        }
    };

    var onepage_nav = function() {
        $('.page-template-front-page .mainnav > ul > li > a').on('click', function() {
            var anchor = $(this).attr('href').split('#')[1];
            var largeScreen = matchMedia('only screen and (min-width: 992px)').matches;
            var headerHeight = 0;
            headerHeight = $('.header').height();
            if (anchor) {
                if ($('#' + anchor).length > 0) {
                    if ($('.header-sticky').length > 0 && largeScreen) {
                        headerHeight = headerHeight;
                    } else {
                        headerHeight = 0;
                    }
                    var target = $('#' + anchor).offset().top - headerHeight;
                    $('html,body').animate({
                        scrollTop: target
                    }, 1000, 'easeInOutExpo');
                }
            }
            return false;
        })

        $('.mainnav ul > li > a').on('click', function() {
            $(this).addClass('active').parent().siblings().children().removeClass('active');
        });
    }

    var onepage_section = function() {
        $('.content-reveal').on('click', function() {
            var anchor = $(this).attr('href').split('#')[1];
            var largeScreen = matchMedia('only screen and (min-width: 992px)').matches;
            var headerHeight = 0;
            headerHeight = $('.header').height();
            if (anchor) {
                if ($('#' + anchor).length > 0) {
                    if ($('.header-sticky').length > 0 && largeScreen) {
                        headerHeight = headerHeight;
                    } else {
                        headerHeight = 0;
                    }
                    var target = $('#' + anchor).offset().top - headerHeight;
                    $('html,body').animate({
                        scrollTop: target
                    }, 1000, 'easeInOutExpo');
                }
            }
            return false;
        })

        $('.mainnav ul > li > a').on('click', function() {
            $(this).addClass('active').parent().siblings().children().removeClass('active');
        });
    }

    var ajaxContactForm = function() {
        $('#contactform').each(function() {
            $(this).validate({
                submitHandler: function(form) {
                    var $form = $(form),
                        str = $form.serialize(),
                        loading = $('<div />', {
                            'class': 'loading'
                        });

                    $.ajax({
                        type: "POST",
                        url: $form.attr('action'),
                        data: str,
                        beforeSend: function() {
                            $form.find('.submit-wrap').append(loading);
                        },
                        success: function(msg) {
                            var result, cls;
                            if (msg == 'Success') {
                                result = 'Message Sent Successfully To Email Administrator. ( You can change the email management a very easy way to get the message of customers in the user manual )';
                                cls = 'msg-success';
                            } else {
                                result = 'Error sending email.';
                                cls = 'msg-error';
                            }

                            $form.prepend(
                                $('<div />', {
                                    'class': 'flat-alert ' + cls,
                                    'text': result
                                }).append(
                                    $('<a class="close" href="#"><i class="fa fa-close"></i></a>')
                                )
                            );

                            $form.find(':input').not('.submit').val('');
                        },
                        complete: function(xhr, status, error_thrown) {
                            $form.find('.loading').remove();
                        }
                    });
                }
            });
        }); // each contactform
    };

    var projectsSlider = function() {
        if ($().flexslider) {
            $('.project-gallery-slider').each(function() {
                var $this = $(this)
                $this.find('.flexslider').flexslider({
                    animation: "slide",
                    direction: "horizontal", // vertical
                    pauseOnHover: true,
                    useCSS: false,
                    easing: "swing",
                    animationSpeed: 500,
                    slideshowSpeed: 5000,
                    controlNav: true,
                    directionNav: true,
                    slideshow: true,
                    smoothHeight: true
                }); // flexslider
            }); // blog-sider
        }
    };

    var flatTestimonial = function() {
        $('.flat-row').each(function() {
            if ($().owlCarousel) {
                $(this).find('.flat-testimonial-owl').owlCarousel({
                    loop: true,
                    margin: 0,
                    nav: true,
                    dots: false,
                    autoplay: true,
                    responsive: {
                        0: {
                            items: 1
                        },
                        767: {
                            items: 1
                        },
                        991: {
                            items: 1
                        },
                        1200: {
                            items: 1
                        }
                    }
                });
            }
        });
    };

    var flatSliderSidebars = function() {
        $('.flat-sidebars').each(function() {
            if ($().owlCarousel) {
                $(this).find('.projects-carousel').owlCarousel({
                    loop: true,
                    margin: 0,
                    nav: true,
                    dots: true,
                    autoplay: true,
                    responsive: {
                        0: {
                            items: 1
                        },
                        767: {
                            items: 1
                        },
                        991: {
                            items: 1
                        },
                        1200: {
                            items: 1
                        }
                    }
                });
            }
        });
    };

    var detectViewport = function() {
        $('[data-waypoint-active="yes"]').waypoint(function() {
            $(this).trigger('on-appear');
        }, {
            offset: '90%',
            triggerOnce: true
        });

        $(window).on('load', function() {
            setTimeout(function() {
                $.waypoints('refresh');
            }, 100);
        });
    };

    var flatCounter = function() {
        $('.counter').on('on-appear', function() {
            $(this).find('.numb-count').each(function() {
                var to = parseInt(($(this).attr('data-to')), 10),
                    speed = parseInt(($(this).attr('data-speed')), 10);
                if ($().countTo) {
                    $(this).countTo({
                        to: to,
                        speed: speed
                    });
                }
            });
        });
    };

    var googleMap = function() {
        if ($().gmap3) {
            $("#flat-map").gmap3({
                map: {
                    options: {
                        zoom: 10,
                        mapTypeId: 'idsgn_style',
                        mapTypeControlOptions: {
                            mapTypeIds: ['idsgn_style', google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.HYBRID]
                        },
                        scrollwheel: false
                    }
                },
                getlatlng: {
                    address: "Beverly Hills, Los Angeles",
                    callback: function(results) {
                        if (!results) return;
                        $(this).gmap3('get').setCenter(new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng()));
                        $(this).gmap3({
                            marker: {
                                latLng: results[0].geometry.location,
                                options: {
                                    icon: 'http://corpthemes.com/html/idsgn/images/icon/ids.png'
                                }
                            }
                        });
                    }
                },
                styledmaptype: {
                    id: "idsgn_style",
                    options: {
                        name: "Idsgn Map"
                    },
                    styles: [{
                            "featureType": "landscape",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "lightness": 65
                                },
                                {
                                    "visibility": "on"
                                }
                            ]
                        },

                        {
                            "featureType": "poi",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "lightness": 51
                                },
                                {
                                    "visibility": "simplified"
                                }
                            ]
                        },

                        {
                            "featureType": "road.highway",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "visibility": "simplified"
                                }
                            ]
                        },

                        {
                            "featureType": "road.arterial",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "lightness": 30
                                },
                                {
                                    "visibility": "on"
                                }
                            ]
                        },
                        {
                            "featureType": "road.local",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "lightness": 40
                                },
                                {
                                    "visibility": "on"
                                }
                            ]
                        },
                        {
                            "featureType": "transit",
                            "stylers": [{
                                    "saturation": -100
                                },
                                {
                                    "visibility": "simplified"
                                }
                            ]
                        },

                        {
                            "featureType": "administrative.province",
                            "stylers": [{
                                "visibility": "off"
                            }]
                        },
                        {
                            "featureType": "water",
                            "elementType": "labels",
                            "stylers": [{
                                    "visibility": "on"
                                },
                                {
                                    "lightness": -25
                                },
                                {
                                    "saturation": -100
                                }
                            ]
                        },
                        {
                            "featureType": "water",
                            "elementType": "geometry",
                            "stylers": [{
                                    "hue": "#ccc"
                                },
                                {
                                    "lightness": 10
                                },
                                {
                                    "saturation": -99
                                }
                            ]
                        }
                    ]
                },
            });
        }
    };

    var popupGallery = function() {
        $('.flat-row').each(function() {
            if ($('a').hasClass('popup-gallery')) {
                $(".popup-gallery").magnificPopup({
                    type: "image",
                    tLoading: "Loading image #%curr%...",
                    removalDelay: 600,
                    mainClass: "my-mfp-slide-bottom",
                    gallery: {
                        enabled: true,
                        navigateByImgClick: true,
                        preload: [0, 1]
                    },
                    image: {
                        tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
                    }
                });
            }
        });
    }

    var portfolioIsotope = function() {
        if ($().isotope) {
            var $container = $('.projects-items');
            $container.imagesLoaded(function() {
                $container.isotope({
                    itemSelector: '.projects',
                    transitionDuration: '1s'
                });
            });

            $('.projects-filter li').on('click', function() {
                var selector = $(this).find("a").attr('data-filter');
                $('.projects-filter li').removeClass('active');
                $(this).addClass('active');
                $container.isotope({
                    filter: selector
                });
                return false;
            });
        };
    };

    var shopTabs = function() {
        $('.woocommerce-tabs').each(function() {

            $(this).children('.content-tab').children().hide();
            $(this).children('.content-tab').children().first().show();

            $(this).find('.tabs').children('li').on('click', function(e) {
                var liActive = $(this).index(),
                    contentActive = $(this).siblings().removeClass('active').parents('.woocommerce-tabs').children('.content-tab').children().eq(liActive);

                contentActive.addClass('active').fadeIn('slow');
                contentActive.siblings().removeClass('active');
                $(this).addClass('active').parents('.woocommerce-tabs').children('.content-tab').children().eq(liActive).siblings().hide();
                e.preventDefault();
            });
        });
    }

    var goTop = function() {
        $(window).scroll(function() {
            if ($(this).scrollTop() > 800) {
                $('.go-top').addClass('show');
            } else {
                $('.go-top').removeClass('show');
            }
        });

        $('.go-top').on('click', function() {
            $("html, body").animate({
                scrollTop: 0
            }, 1000, 'easeInOutExpo');
            return false;
        });
    };

    var flatFilterPrice = function() {
        if ($().slider) {
            $(".price_slider").slider({
                range: true,
                min: 10,
                max: 90,
                values: [10, 90],
                slide: function(event, ui) {
                    $(".price_label > input ").val("£" + ui.values[0] + "  - £" + ui.values[1]);
                }
            });

            $(".price_label > input ").val("£" + $(".price_slider").slider("values", 0) +
                "  -  £" + $(".price_slider").slider("values", 1));
            $(".ui-slider-handle").append("<span class='shadow'></span>");
        }
    };

    var retinaLogos = function() {
        var retina = window.devicePixelRatio > 1 ? true : false;
        if (retina) {
            $('.header .logo').find('img').attr({
                src: './images/logo@2x.png',
                width: '145',
                height: '35'
            });
        }
    };

    var parallax = function() {
        if ($().parallax && isMobile.any() == null) {
            $('.parallax1').parallax("50%", 0.3);
            $('.parallax2').parallax("50%", 0.3);
            $('.parallax3').parallax("50%", 0.3);
            $('.parallax4').parallax("50%", -0.5);
        }
    };

    var removePreloader = function() {
        $('.loading-overlay').fadeOut('slow', function() {
            $(this).remove();
        });
    };

    // Dom Ready
    $(function() {
        if (matchMedia('only screen and (min-width: 991px)').matches) {
            headerFixed();
        }

        menuDesktop();
        onepage_nav();
        onepage_section();
        googleMap();
        goTop();
        popupGallery();
        flatFilterPrice();
        projectsSlider();
        portfolioIsotope();
        shopTabs();
        flatCounter();
        responsiveMenu();
        flatTestimonial();
        detectViewport();
        ajaxContactForm();
        flatSliderSidebars();
        retinaLogos();
        parallax();
        removePreloader();
    });

})(jQuery);