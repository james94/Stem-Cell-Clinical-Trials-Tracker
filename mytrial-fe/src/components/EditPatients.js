import React, { Component } from 'react'
// import Select from 'react-select'

class EditPatients extends Component {
    constructor(props) {
      super(props);
      this.state = {value: ''};
      this.handleChange = this.handleChange.bind(this);
      this.handleSubmit = this.handleSubmit.bind(this);
    }
  
    handleChange(event) {  this.setState({value: event.target.value});alert(event.target.value); setTimeout(function() {}, 10000);
    // alert('A name was submitted: ' + this.state.value); 
}
    handleSubmit(event) {
      alert('A name was submitted: ' + this.state.value);
      event.preventDefault();
    }
    //
    render() {
        var x;
        if(this.state.value==='edit'){
            x=(<div>edit form</div>)
        }
        if(this.state.value==='delete'){
            x=(<div>delete form</div>)
        }
        if(this.state.value==='add'){
            x=(<div>add form</div>)
        }
      return (
          <div className="container">
              <div className="row">
                  <div className="col-md-6 text-center">
                    <select ref="imageType" className="mb-5 mt-5" value={this.state.value} onChange={this.handleChange}>
                        <option value=''></option>
                        <option value="edit">Edit patient list</option>
                        <option value="delete">Delete a patient from the list</option>
                        <option value="add">Add patient to the list</option>
                </select>
                <br />
                <button className="btn btn-primary text-center" onClick={this.handleSubmit}>Export Chart</button>
                <br />
                <div className="text-center mt-3">{x}</div>
                </div>
            </div>

        </div>
      );
    }
  }

  export default EditPatients;