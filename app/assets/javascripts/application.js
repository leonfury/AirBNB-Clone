// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function(){
    let c_in = document.getElementById('check_in_date');
    let c_out = document.getElementById('check_out_date');
    let price = document.getElementById('price_per_night');

    function to_date(str) {
        parts = str.split('-');
        d =  new Date(parts[0], parts[1] - 1, parts[2]);
        // console.log(`date is ${d}`)
        return d;
    }

    function execute_book(check_in, check_out) {
        let d_in = to_date(check_in);
        let d_out = to_date(check_out);
        let nights = (d_out - d_in) / 60 / 60 / 24 / 1000;
        let calc_price = nights * price.innerHTML;
        $('#disp_total_nights').html(nights);
        $('#disp_total_price').html(calc_price);
        color_dates(d_in, d_out, nights);
    }

    function date_increment(date) {
        // console.log('date passed in : ' + date);
        new_d = new Date(date)
        d = new Date(new_d.setDate(new_d.getDate() + 1));

        year = d.getFullYear()
        month = d.getMonth() + 1
        date = d.getDate()

        if (month < 10) { month = '0' + month }

        if (date < 10) { date = '0' + date }
        increment = year + "-" + month + "-" + date;
        return increment;
    }

    function to_date_str(date) {
        new_d = new Date(date)
        d = new Date(new_d.setDate(new_d.getDate()));

        year = d.getFullYear()
        month = d.getMonth() + 1
        date = d.getDate()

        if (month < 3) { month = '0' + month }

        if (date < 10) { date = '0' + date }
        date_str = year + "-" + month + "-" + date;
        return date_str;
    }

    function color_dates(start_at, end_at, loop) {
        $(".bg-success").addClass("bg-success text-dark");
        $(".bg-success").removeClass("bg-success text-white border rounded-circle");
        color = start_at
        booking_valid = true;
        for (let i = 0; i <= loop; i++ ) {
            // convert date to string id
            color_str = to_date_str(color);
           
            // search for id
            if ($(`#${color_str}`).hasClass("bg-danger")) {
                booking_valid = false;
            }
            else {
                $(`#${color_str}`).removeClass("text-dark")
                $(`#${color_str}`).addClass("border rounded-circle bg-success text-white");
            }

            // color

            // date + 1
            color = date_increment(color);
   
        }
        if (booking_valid) {
            $('#create_booking_button').removeClass('d-none');
            $('#booking_valid').addClass('d-none');
        }
        else {
            $('#create_booking_btn').addClass('d-none');
            $('#booking_valid').removeClass('d-none');
        }
    }

    $(".c_day").click(function(){
        console.log(event.target);
        console.log(event.target.id);
    })

    $("#check_in_date").change(function(){
        if (c_out.value != "") {
            execute_book(c_in.value, c_out.value);
        }
        $("#check_out_date").attr('min', date_increment(c_in.value));
    })

    $("#check_out_date").change(function(){
        execute_book(c_in.value, c_out.value);
    })

})
