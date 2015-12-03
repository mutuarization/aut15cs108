var answerHTML = document.getElementById('answerData').innerHTML;
var type = document.getElementById('type').getAttribute('value');
if (type == 'Question-Response'){
  answerHTML+='What Answer are you looking for?'+
  '<br>'+
  '<input type="text" name="answer">'+
  '<br>';
}
if (type == 'Fill in the Blank' || type == 'Picture Response'){
	answerHTML+='What Answer(s) are you looking for? Separate multiple blanks with Semicolons.'+
	'<br>';
	var numBlanks = +document.getElementById('number').value;
	for (var i = 0; i < numBlanks; i++){
	  answerHTML+='<input type="text" name="answer" value="default">'+
	  '<br>';
	}
}
if (type == 'Multiple Choice'){
	answerHTML+='What answers are you looking for? Also, check the correct one(s)'+
	'<br>';
	var numChoices = +document.getElementById('number').value;
	for (var i = 0; i < numChoices; i++){
		answerHTML+='<input type="text" name="answer">'+
		'<input type="checkbox" name="correct" value="' + i + '">'+
		'<br>';
	}
	var correctRadioButtons = document.getElementsByName('correct');
	for (var i = 0; i < correctRadioButtons.length; i++){
		correctRadioButtons[i].onclick = choiceOnClick;
	}
}
if (type == 'Matching'){
	answerHTML+='Fill in the prompts on the left, and the Answers on the right'+
	'<br>';
	var numPairs = +document.getElementById('number').value;
	for (var i = 0; i < numPairs; i++){
		answerHTML+='<input type="text" name="prompt"><input type="text" name="answer">'
		'<br>';
	}
}
answerHTML+='<input type="submit" name="answerSumbit" value="Add this Answer!">';
document.getElementById('answerData').innerHTML = answerHTML;

function choiceOnClick(){
	var correctChoices = document.getElementById('correctChoices').getAttribute('value');
	if (this.checked){
		if (correctChoices.indexOf(this.value+';') == -1){
			correctChoices+=this.value+';';
		}
	}
	else if (!this.checked){
		if (correctChoices.indexOf(this.value+';') != -1){
			correctChoices.replace(this.value+';', '');
		}
	}
	document.getElementById('correctChoices').setAttribute('value', correctChoices);
}
