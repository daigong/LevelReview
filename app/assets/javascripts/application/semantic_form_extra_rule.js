/**
 * Created by .
 * User: daigong
 * add "semantic_form_for" extra rule ,need jquery
 */

//add validator rules
//params validators is validators_rule_build_by_client_validators
//$validate_input self define input rule
$.add_semantic_form_extra_rule = function(validators, $validate_input) {
    var input_clazz = $validate_input.parents('li').attr('class')
    if (input_clazz) {
        var class_array = input_clazz.split(" ");
        var rule = {}
        for (var index in class_array) {
            var rule_type = class_array[index]
            if (rule_type == 'required') {
                //message is same in i18n /config/locales/
                rule["presence"] = {"message":"该字段不能为空"}
            }
        }
        validators[$validate_input.attr('name')] = rule
    }
}

$(function() {
    $('.formtastic li *[data-extra-validate]').each(function() {
        var $this = $(this)
        var $form = $this.parents('form.formtastic')
        if ($form.attr('data-validate')) {
            //if form used formtastic and date-validate is true
            var form_id = $form.attr('id')
            // get the validators rule & add rule in it
            var validators = window[form_id].validators
            $.add_semantic_form_extra_rule(validators, $this);
        }
    })
});