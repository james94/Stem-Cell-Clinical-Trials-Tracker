import {
    ComboBox,
    IComboBox,
    IComboBoxOption,
    IComboBoxStyles,
    SelectableOptionMenuItemType,
    PrimaryButton,
    IButtonStyles,
  } from '@fluentui/react';
import React from 'react';
import { Link } from 'react-router-dom';
import UnauthorizedPage from './UnauthorizedPage';
import { DetailsList, DetailsListLayoutMode, Selection, IColumn } from '@fluentui/react/lib/DetailsList';
import { TextField, ITextFieldStyles } from '@fluentui/react/lib/TextField';

const comboBoxStyles = { root: { margin:'10px', maxWidth: 300 } };
const buttonStyles= { root: { display: 'block', margin: '10px 0 20px' } };

class WatchListPage extends React.Component {

    constructor(props) {
        super(props);
        //TODO: fill options based on values from watchlist table
        const _options = [
          { key: 'A', text: 'Brain Cancer' },
          { key: 'B', text: 'Cancer' },
          { key: 'C', text: 'Solid Tumors' },
          { key: 'D', text: 'Acute Myeloid Leukemia' },
        ];
        //TODO: get lis of diseases for a researcher ID
        const _items = [
          {
              key: 1,
              dname: "Disease Name 1",
              pid: 1,
          },
          {
              key: 2,
              dname: "Disease Name 2",
              pid: 2,
          }
        ]
        this.state = {
            searchTerm: "",
            items:_items,
            options:_options
        };
    
        // This binding is necessary to make `this` work in the callback
        this.handleButtonSubmit = this.handleButtonSubmit.bind(this);
        this.handleDiseaseClick = this.handleDiseaseClick.bind(this);
      }

    handleButtonSubmit(e) {
        e.preventDefault();
        
        console.log(e.target.elements.search.value);
        
    }

    handleDiseaseClick(e){
        console.log(e.target);
    }

    render() {

        const role = "researcher"; //TODO: get value from somewhere. Props or localstorage or DB
        this._columns = [
            { key: '', name: 'Patient ID', fieldName: 'pid', minWidth: 100, maxWidth: 200, isResizable: true },
            { key: '', name: 'Disease Name', fieldName: 'dname', minWidth: 100, maxWidth: 200, isResizable: true },
        ];
        

        if(role == "patient"){
            return <UnauthorizedPage />
        }
        else if(role == "researcher"){
            return(
                <div>
                    <div>
                        <ComboBox
                          defaultSelectedKey="C"
                          label="Choose disease"
                          options={this.state.options}
                          styles={comboBoxStyles}
                          onItemClick = {this.handleDiseaseClick}
                        />
                        <PrimaryButton 
                            text="Add to watchlist" 
                            onClick={this.handleSubmit}
                            styles={buttonStyles}
                        />
                    </div>
                    <div>
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

export default WatchListPage;