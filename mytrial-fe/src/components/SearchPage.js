import React from 'react';
import { Link } from 'react-router-dom';
import UnauthorizedPage from './UnauthorizedPage';
import { DetailsList, DetailsListLayoutMode, Selection, IColumn } from '@fluentui/react/lib/DetailsList';
import { TextField, ITextFieldStyles } from '@fluentui/react/lib/TextField';

class SearchPage extends React.Component {

    constructor(props) {
        super(props);

        _items = [
            {
                key: 1,
                pname: "Name1",
                pid: 1,
            },
            {
                key: 2,
                pname: "Name2",
                pid: 2,
            }
        ]

        this.state = {
            searchTerm: "",
            items:this._items
        };
    
        // This binding is necessary to make `this` work in the callback
        this.handleSubmit = this.handleSubmit.bind(this);
        this.handleChange = this.handleChange.bind(this);
      }

    handleSubmit(e) {
        e.preventDefault();
        
        this.setState({searchTerm: e.target.elements.search.value});
        
    }

    handleChange(e) {
        e.preventDefault();
        console.log('You are typing.');
        let text = e.target.value;
        this.setState({
            items: text ? this._items.filter(i => i.pname.toLowerCase().indexOf(text.toLowerCase()) > -1) : this._items,
        });
        
    }


    render() {

        const role = "researcher"; //TODO: get value from somewhere. Props or localstorage or DB
        this._columns = [
            { key: '', name: 'PatientID', fieldName: 'pid', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: '', name: 'PatientName', fieldName: 'pname', minWidth: 100, maxWidth: 200, isResizable: true },
        ];
        

        if(role == "patient"){
            return <UnauthorizedPage />
        }
        else if(role == "researcher"){
            return(
                <div>
                    <div>
                    <TextField
                      label="Search"
                      onChange={this.handleChange}
                    />
                    </div>

                    <div className="resultsDiv">
                    <DetailsList
                        items={this.state.items}
                        columns={this._columns}
                        setKey="set"
                        layoutMode={DetailsListLayoutMode.justified}
                    />

                    </div>
                    
                </div>


            );
        }
      
    }

  }

export default SearchPage;